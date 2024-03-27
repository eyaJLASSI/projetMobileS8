//
//  SwiftUIView.swift
//  
//
//  Created by etud on 25/03/2024.
//

import SwiftUI

import SwiftUI

struct PlanningInscriptions: View {
    
    @State var selectedDay : String
    @State var pseudo      : String
    @ObservedObject var planningVM : PlanningViewModel
    
    //Variables pour la navigation vers ProfileView
    let benevoleVM: BenevoleViewModel
    
    //Variables pour la navigation vers PlanningPersonnel
    @ObservedObject var sinscrireVM : SinscrireViewModel
    
    //Variables pour la navigation vers PlanningCandidature
    @ObservedObject var candidaterVM : CandidaterViewModel
    @ObservedObject var planningCandVM : PlanningCandidatureViewModel
    
    var creneaux: [CreneauDTO] {
        planningVM.creneaux
            .filter { $0.jourCreneau == selectedDay }
            .sorted { $0.heureDebut > $1.heureDebut }
    }
    
    var espaces : [EspaceDTO] {
        planningVM.espaces
            .sorted { $0.libelleEspace > $1.libelleEspace }
    }
    
    func GetNbPlace(idCreneau : Int, idEspace : Int) -> Int
    {
        let key: Two<Int, Int> = Two(values: (idCreneau, idEspace))
        let nbPlace = planningVM.nombrePlaceTotal[key, default: 0]
        
        let inscription : Int = planningVM.inscriptions
            .filter { $0.espaceId == idEspace && $0.creneauId == idCreneau }
            .count
        
        return nbPlace - inscription;
    }
    
    func GetPoste(espace : EspaceDTO) -> String
    {
        var posteOrNil = planningVM.postes.first { $0.idP == espace.posteId }
        guard let poste = posteOrNil
        else {
            // Ne devrait jamais arriver
            return "UNKNOWN"
        }
        
        return poste.libellePoste;
    }
    
    func getInscription(pseudo: String, idCreneau : Int, idEspace : Int, idF: Int) -> InscriptionDTO?
    {
        var inscriptionOrNil : InscriptionDTO? = planningVM.inscriptions
            .first { $0.creneauId == idCreneau && $0.espaceId == idEspace && $0.benevolePseudo == pseudo && $0.idF == idF}
        
        guard let inscriptionOrNil = inscriptionOrNil
        else
        {
            return nil
        }
        return inscriptionOrNil
    }
    
    func inscriptionExist(pseudo: String, idCreneau : Int, idEspace : Int, idF: Int) -> Bool
    {
        var inscriptionOrNil = getInscription(pseudo: pseudo, idCreneau : idCreneau, idEspace : idEspace, idF: idF)
        
        guard let _ = inscriptionOrNil
        else
        {
            return false
        }
        return true
    }
    
    func getCandidature(pseudo: String, idCreneau : Int, idF: Int) -> CandidatureDTO?
    {
        var candidatureOrNil : CandidatureDTO? = planningVM.candidatures
            .first { $0.idF == idF && $0.creneauId == idCreneau && $0.benevolePseudo == pseudo }
        
        guard let candidature = candidatureOrNil
        else
        {
            return nil
        }
        
        debugPrint("Found Candidature \(candidature)")
        return candidature
    }
    
    func candidatureExist(pseudo: String, idCreneau : Int, idF: Int) -> Bool
    {
        var candidatureOrNil = getCandidature(pseudo: pseudo, idCreneau : idCreneau, idF: idF)
        
        guard let _ = candidatureOrNil
        else
        {
            return false
        }
        return true
    }
    
    func inscriptionExistInCreneau(pseudo: String, idCreneau : Int, idF: Int) -> Bool
    {
        var inscriptionOrNil : InscriptionDTO? = planningVM.inscriptions
            .first { $0.creneauId == idCreneau && $0.benevolePseudo == pseudo && $0.idF == idF}
        
        guard let _ = inscriptionOrNil
        else
        {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView{
            VStack{
                let planningIntent    = PlanningIntent(planningViewModel: planningVM)
                let inscriptionIntent = SinscrireIntent(planningViewModel: planningVM)
                
                Button(action: {
                    selectedDay = selectedDay == "Samedi" 
                    ? "Dimanche"
                    : "Samedi"
                }) {
                    Text(selectedDay)
                        .font(.title)
                        .padding()
                }
                
                ScrollView{
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("")
                                .frame(width: 100, height: 100)
                                .background(Color.white)
                            ForEach(creneaux, id: \.self) { creneau in
                                Button(action: {
                                    Task {
                                        if (!candidatureExist(pseudo: pseudo, idCreneau: creneau.idC, idF: 2))
                                        {
                                            debugPrint("Will create candidature")
                                            await inscriptionIntent.candidater(pseudo: pseudo, creneauId: creneau.idC, idF: 2)
                                        }
                                        else {
                                            
                                            var candidature = getCandidature(pseudo: pseudo, idCreneau: creneau.idC, idF: 2)
                                            debugPrint("Delete candidature \(candidature!.id)")
                                            await inscriptionIntent.decandidater(idCandidature: candidature!.id)
                                        }
                                    }
                                }) {
                                    Text("\(creneau.heureDebut) - \(creneau.heureFin)")
                                        .frame(width: 100, height: 100)
                                        .background(Color.gray)
                                        .border(Color.black)
                                }
                            }
                        }
                        ForEach(espaces, id: \.self) { espace in
                            HStack(spacing: 0) {
                                Text("\(GetPoste(espace : espace))")
                                    .frame(width: 100, height: 100)
                                    .background(Color.gray)
                                    .border(Color.black)
                                ForEach(creneaux, id: \.self) { creneau in
                                    Button(action: {
                                        Task {
                                            if (candidatureExist(pseudo: pseudo, idCreneau: creneau.idC, idF: 2))
                                            {
                                                return;
                                            }
                                            
                                            if(inscriptionExist(pseudo: pseudo, idCreneau: creneau.idC, idEspace: espace.idEspace, idF: 2))
                                            {
                                                let inscription = getInscription(pseudo: pseudo, idCreneau: creneau.idC, idEspace: espace.idEspace, idF: 2)
                                                await inscriptionIntent.seDesinscrire(idInscription: inscription!.id)
                                                return;
                                                
                                            }
                                            if (!inscriptionExistInCreneau(pseudo: pseudo, idCreneau: creneau.idC, idF: 2)
                                                && GetNbPlace(idCreneau: creneau.idC, idEspace: espace.idEspace) > 0)
                                            {
                                                await inscriptionIntent.sinscrire(benevolePseudo: pseudo, creneauId: creneau.idC, espaceId: espace.idEspace, idF: 2)
                                            }
                                        }
                                    }) {
                                        Text("\(GetNbPlace(idCreneau: creneau.idC, idEspace: espace.idEspace))")
                                            .frame(width: 100, height: 100)
                                            .background(inscriptionExist(pseudo: pseudo, idCreneau: creneau.idC, idEspace: espace.idEspace, idF: 2) ? Color(red: 0.3, green: 0.3, blue: 0.5, opacity: 0.1) : candidatureExist(pseudo: pseudo, idCreneau: creneau.idC, idF: 2) ? Color(red: 0.0, green: 0.3, blue: 0.81, opacity: 0.3) : Color.white)
                                            .border(Color.black)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    Task {
                        var result2 = await planningIntent.getPlanning(idF: 2)
                        
                        if (result2)
                        {
                            // debugPrint("Planning :")
                            // for inscription in planningVM.inscriptions
                            // {
                            //     debugPrint("=====INSCRIPTIONS=====")
                            //     debugPrint(inscription)
                            //     debugPrint("=====================")
                            // }
                            //
                            // for poste in planningVM.postes
                            // {
                            //     debugPrint("=====POSTES=====")
                            //     debugPrint(poste)
                            //     debugPrint("=====================")
                            // }
                            //
                            // for creneau in planningVM.creneaux
                            // {
                            //     debugPrint("=====CRENEAUX=====")
                            //     debugPrint(creneau)
                            //     debugPrint("=====================")
                            // }
                            //
                            // for espace in planningVM.espaces
                            // {
                            //     debugPrint("=====ESPACES=====")
                            //     debugPrint(espace)
                            //     debugPrint("=====================")
                            // }
                            //
                            // for nbPlace in planningVM.nombrePlaceTotal
                            // {
                            //     debugPrint("=====NB PLACE=====")
                            //     debugPrint("\(nbPlace.key) -> \(nbPlace.value)")
                            //     debugPrint("=====================")
                            // }
                            
                            for candidature in planningVM.candidatures
                            {
                                debugPrint("=====CANDIDATURES=====")
                                debugPrint("\(candidature)")
                                debugPrint("=====================")
                            }
                        }
                        else
                        {
                            debugPrint(">:(")
                        }
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: ProfileView(benevoleVM: benevoleVM, sinscrireVM: sinscrireVM, candidaterVM: candidaterVM, planningCandVM: planningCandVM, selectedDay: selectedDay, pseudo: pseudo, planningVM: planningVM)){
                        Image(systemName: "person")
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: PlanningPersonnelView(sinscrireVM: sinscrireVM, benevoleVM: benevoleVM, candidaterVM: candidaterVM, planningCandVM: planningCandVM, selectedDay: selectedDay, pseudo: pseudo, planningVM: planningVM)){
                        Image(systemName: "calendar")
                    }
                    
                    Spacer()
                    
                    
                    NavigationLink(destination: PlanningInscriptions(selectedDay: selectedDay, pseudo: pseudo, planningVM: planningVM, benevoleVM: benevoleVM, sinscrireVM: sinscrireVM, candidaterVM: candidaterVM, planningCandVM: planningCandVM)){
                        Image(systemName: "list.bullet.clipboard")
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: PlanningCandidatureView(candidaterVM: candidaterVM, planningCandVM: planningCandVM, benevoleVM: benevoleVM, sinscrireVM: sinscrireVM, selectedDay: selectedDay, pseudo: pseudo, planningVM: planningVM)){
                        Image(systemName: "hourglass")
                    }
                    Spacer()
                    
                    /*
                     NavigationLink(destination: FithView()){
                     Image(systemName: "info.circle")
                     }
                     Spacer()
                     */
                }
                .padding()
                .foregroundColor(.blue)
            }
        }
        .navigationBarHidden(true)
    }
}
/*
 struct Samedi_Previews: PreviewProvider {
 static var previews: some View {
 PlanningInscriptions(selectedDay: "Samedi", pseudo: "blipbloup",planningVM: PlanningViewModel())
 }
 }
 */
