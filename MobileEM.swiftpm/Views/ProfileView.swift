//
//  SwiftUIView.swift
//  
//
//  Created by etud on 15/03/2024.
//

import SwiftUI


struct ProfileView: View {
    @ObservedObject var benevoleVM: BenevoleViewModel
    
    @State private var modeModif : Bool = false
    
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
        let benevoleIntent = BenevoleIntent(benevole: benevoleVM)
        
        ScrollView {
            VStack {
                Text("Profil de \(benevoleVM.pseudo)")
                    .font(.title)
                    .padding(40)
                
                if modeModif {
                    TextField("Nom", text: $benevoleVM.nom)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding([.top, .leading, .trailing])
                    
                    TextField("Prénom", text: $benevoleVM.prenom)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    
                    TextField("Email", text: $benevoleVM.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    
                    TextField("Numéro de tel", text: $benevoleVM.numTel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    
                    TextField("Taille du tee shirt", text: $benevoleVM.taille)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    
                    Text("Végétarien ?")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    
                    Toggle("Végétarien", isOn: $benevoleVM.vegetarien)
                    
                    Text("Besoin d'un logement ?")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    
                    Toggle("Cherche logement", isOn: $benevoleVM.chercheLogement)
                    
                    
                } else {
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
                    
                    Text("Végétarien : \(benevoleVM.vegetarien ? "Oui" : "Non")")
                    
                    Text("Besoin d'un logement : \(benevoleVM.chercheLogement ? "Oui" : "Non")")
                        .padding(10)
                    
                }
                
                Spacer()
                // Remplacer le bouton par une NavigationLink
                Button(action: {
                    Task {
                        if (modeModif)
                        {
                            let benevole = BenevoleModifDTO(benevoleVM: benevoleVM)
                            await benevoleIntent.updateBenevole(pseudo: benevoleVM.pseudo, updatedBenevole: benevole)
                            modeModif = false
                        }
                        else
                        {
                            modeModif = true
                        }
                    }
                }, label: {
                    Text(self.modeModif ? "Valider" : "Modifier Profil")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                
                Spacer()
                HStack {
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
                    
                    NavigationLink(destination: LoginView()){
                        Image(systemName: "power.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                    }
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


