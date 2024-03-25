//
//  SwiftUIView.swift
//  
//
//  Created by etud on 15/03/2024.
//

import SwiftUI


struct ProfileView: View {
    let benevoleVM: BenevoleViewModel
    
    let pseudo : String
    
    @ObservedObject var sinscrireVM : SinscrireViewModel
    
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
                    
                    NavigationLink(destination: ProfileView(benevoleVM: benevoleVM, pseudo: pseudo, sinscrireVM: sinscrireVM)){
                        Image(systemName: "person")
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: PlanningPersonnelView(sinscrireVM: sinscrireVM, benevoleVM: benevoleVM, pseudo: pseudo)){
                        Image(systemName: "calendar")
                    }
                    
                    Spacer()
                    
                    /*
                     NavigationLink(destination: InscriptionSamediView()){
                     Image(systemName: "list.bullet.clipboard")
                     }
                     
                     Spacer()
                     
                     NavigationLink(destination: ProfilView()){
                     Image(systemName: "hourglass")
                     }
                     Spacer()
                     
                     
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let user = BenevoleViewModel()
        return ProfileView(benevoleVM: user, pseudo: "blipbloup", sinscrireVM: SinscrireViewModel(inscriptionDTOs: []))
    }
}


