//
//  SwiftUIView.swift
//  
//
//  Created by etud on 15/03/2024.
//

import SwiftUI


struct ProfileView: View {
    let benevoleVM: BenevoleViewModel
    
    //Variables pour la navigation vers PlanningPersonnel
    @ObservedObject var sinscrireVM : SinscrireViewModel
    
    //Variables pour la navigation vers PlanningCandidature
    @ObservedObject var candidaterVM : CandidaterViewModel
    @ObservedObject var planningCandVM : PlanningCandidatureViewModel
    
    //Variables pour la navigation vers PlanningInscriptions
    @State var selectedDay : String
    let pseudo : String
    @ObservedObject var planningVM : PlanningViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Profil de \(benevoleVM.pseudo)")
                    .font(.title)
                    .padding(40)
                
                VStack(alignment: .leading){
                    
                    Text("Nom : \(benevoleVM.nom)")
                        .padding(10)
                    
                    Text("Prénom : \(benevoleVM.prenom)")
                        .padding(10)
                   
                    Text("Email : \(benevoleVM.email)")
                        .padding(10)
                    
                    Text("Pseudo : \(benevoleVM.pseudo)")
                        .padding(10)
                    
                    Text("Numéro de téléphone : \(benevoleVM.numTel)")
                        .padding(10)
                    
                    Text("Taille du t-shirt : \(benevoleVM.taille)")
                        .padding(10)
                    
                    if(benevoleVM.vegetarien == true){
                        Text("Végétarien : Oui")
                            .padding(10)
                    } else {
                        Text("Végétarien : Non")
                            .padding(10)
                    }
                    
                    if(benevoleVM.chercheLogement == true){
                        Text("Besoin d'un logement : Oui")
                            .padding(10)
                    } else {
                        Text("Besoin d'un logement : Non")
                            .padding(10)
                    }
                }
                Spacer()
                // Remplacer le bouton par une NavigationLink
                Button(action: {
                    print("modification")
                }, label: {
                    Text("Modifier Profil")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
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
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let user = BenevoleViewModel()
        return ProfileView(benevoleVM: user, pseudo: "blipbloup", sinscrireVM: SinscrireViewModel(inscriptionDTOs: []))
    }
}
 */


