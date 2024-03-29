//
//  SwiftUIView.swift
//  PlanningCandidatureView
//
//  Created by etud on 22/03/2024.
//

import SwiftUI

struct PlanningCandidatureView: View {
    @ObservedObject var candidaterVM : CandidaterViewModel
    
    //TEST TO REMOVE
    @ObservedObject var planningCandVM : PlanningCandidatureViewModel
    
    //Variables pour la navigation vers ProfileView
    let benevoleVM: BenevoleViewModel
    
    //Variables pour la navigation vers PlanningPersonnel
    @ObservedObject var sinscrireVM : SinscrireViewModel
    
    //Variables pour la navigation vers PlanningInscriptions
    @State var selectedDay : String
    let pseudo : String
    @ObservedObject var planningVM : PlanningViewModel
    
    
    var samediCandidatures: [CandidatureWithAllInfosDTO] {
        candidaterVM.candidatures
            .filter { $0.creneauDto.jourCreneau == "Samedi" }
            .sorted { $0.creneauDto.heureDebut > $1.creneauDto.heureDebut }
    }
    
    var dimancheCandidatures: [CandidatureWithAllInfosDTO] {
        candidaterVM.candidatures
            .filter { $0.creneauDto.jourCreneau == "Dimanche" }
            .sorted { $0.creneauDto.heureDebut > $1.creneauDto.heureDebut }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                let candidatureIntent = CandidatureIntent(candidatureViewModel: candidaterVM)
                
                // TEST TO REMOVE
                //let planningIntent = PlanningIntent(planningViewModel: planningVM)
                
                VStack{
                    HStack{
                        Text("Planning inscriptions en attente")
                            .font(.title)
                            .padding(40)
                    }
                    ScrollView{
                        Text("Samedi")
                            .font(.title3)
                        ForEach(samediCandidatures, id: \.self) { candidature in
                            HStack{
                                Text("\(candidature.creneauDto.heureDebut) - \(candidature.creneauDto.heureFin)")
                                    .padding(10)
                                Divider()
                                Text(candidature.espaceDto.libelleEspace)
                                
                                Spacer()
                            }
                            Divider()
                        }
                        Spacer(minLength: 70)
                        Text("Dimanche")
                            .font(.title3)
                        ForEach(dimancheCandidatures, id: \.self) {candidature in
                            HStack{
                                Text("\(candidature.creneauDto.heureDebut) - \(candidature.creneauDto.heureFin)")
                                    .padding(10)
                                Divider()
                                Text(candidature.espaceDto.libelleEspace)
                                
                                Spacer()
                                /*
                                Button(action: {
                                    print("Supprime")
                                }){
                                    Image(systemName: "trash")
                                }
                                 */
                                .padding(10)
                            }
                            Divider()
                        }
                    }
                }
                .onAppear {
                    // Call your function here
                    Task {
                        // Perform your setup tasks or fetch data here
                        debugPrint("Fetching data...")
                        
                        var result = await candidatureIntent.getCandidaturesByPseudo(pseudo: pseudo)
                        
                        // TEST TO REMOVE
                        //var result2 = await planningIntent.getPlanning(idF: 2)
                        
                        if (result)
                        {
                            //debugPrint("Wihii")
                            //debugPrint(sinscrireVM.inscriptions.count)
                            //for inscription in sinscrireVM.inscriptions
                            //{
                            //    debugPrint("=====================")
                            //    debugPrint(inscription)
                            //    debugPrint("=====================")
                            //}
                        }
                        else
                        {
                            debugPrint(":c")
                        }
                        
                        // TEST TO REMOVE
                        /*
                         if (result2)
                         {
                         debugPrint("Planning :")
                         for inscription in planningVM.inscriptions
                         {
                         debugPrint("=====INSCRIPTIONS=====")
                         debugPrint(inscription)
                         debugPrint("=====================")
                         }
                         
                         for poste in planningVM.postes
                         {
                         debugPrint("=====POSTES=====")
                         debugPrint(poste)
                         debugPrint("=====================")
                         }
                         
                         for creneau in planningVM.creneaux
                         {
                         debugPrint("=====CRENEAUX=====")
                         debugPrint(creneau)
                         debugPrint("=====================")
                         }
                         
                         for espace in planningVM.espaces
                         {
                         debugPrint("=====ESPACES=====")
                         debugPrint(espace)
                         debugPrint("=====================")
                         }
                         
                         for nbPlace in planningVM.nombrePlaceTotal
                         {
                         debugPrint("=====NB PLACE=====")
                         debugPrint("\(nbPlace.key) -> \(nbPlace.value)")
                         debugPrint("=====================")
                         }
                         }
                         else
                         {
                         debugPrint(">:(")
                         }
                         */
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
     

struct PlanningCandidatureViewView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningCandidatureView(candidaterVM: CandidaterViewModel(candidatureDTOs: []), planningCandVM: PlanningCandidatureViewModel(), benevoleVM: BenevoleViewModel(), sinscrireVM: SinscrireViewModel(inscriptionDTOs: []), selectedDay: "Samedi", pseudo: "blipbloup", planningVM: PlanningViewModel())

    }
}
     
     

