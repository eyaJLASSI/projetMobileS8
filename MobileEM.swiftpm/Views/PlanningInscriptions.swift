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
    
    //let creneaux = ["8h - 11h", "11h - 14h", "14h - 17h"]
    
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
        var inscriptionOrNil : InscriptionDTO? = planningVM.inscriptions
            .first { $0.creneauId == idCreneau && $0.espaceId == idEspace && $0.benevolePseudo == pseudo && $0.idF == idF}
        
        guard let _ = inscriptionOrNil
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
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("")
                    .frame(width: 100, height: 100)
                    .background(Color.white)
                ForEach(creneaux, id: \.self) { creneau in
                    Text("\(creneau.heureDebut) - \(creneau.heureFin)")
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                        .border(Color.black)

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
                                .background(inscriptionExist(pseudo: pseudo, idCreneau: creneau.idC, idEspace: espace.idEspace, idF: 2) ? Color(red: 0.3, green: 0.3, blue: 0.5, opacity: 0.1) : Color.white)
                                .border(Color.black)
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
                }
                else
                {
                    debugPrint(">:(")
                }
            }
        }
    }
}

struct Samedi_Previews: PreviewProvider {
    static var previews: some View {
        PlanningInscriptions(selectedDay: "Samedi", pseudo: "blipbloup",planningVM: PlanningViewModel())
    }
}
