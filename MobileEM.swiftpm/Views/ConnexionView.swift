//
//  SwiftUIView.swift
//
//
//  Created by etud on 13/03/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoggedIn = false
    @ObservedObject private var viewModel = BenevoleViewModel()
    @State private var isShowingInscriptionView = false //State pour gérer la navigation

    
    var body: some View {
        let authentificationIntent = AuthentificationIntent(benevoleViewModel: viewModel)
        
        NavigationView {
        VStack {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            
            Text("Connexion")
                .font(.title)
                .padding()
            
            TextField("Nom Utilisateur", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            
            SecureField("Mot de passe", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            
            Button(action: {
                // Action à exécuter lorsque le bouton est appuyé
                Task
                {
                    await self.login()
                }
            }) {
                Text("Se connecter")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button(action: {
                self.isShowingInscriptionView = true //Navigation vers InscriptionView
            }) {
                Text("S'inscrire")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                }
            .padding()
            
            Spacer()
        }
        }
        .padding()
        .navigationBarHidden(true) // Masquer la barre de navigation de cette vue
        .sheet(isPresented: $isShowingInscriptionView) {
            InscriptionView() // Afficher InscriptionView lorsque isShowingInscriptionView est vrai
        }
        .fullScreenCover(isPresented: $isLoggedIn) {
            ProfileView(benevoleVM: viewModel) // Afficher ProfilView lorsque isLoggedIn est vrai
        }
    }
    
    func login() async {
        let authentificationIntent = AuthentificationIntent(benevoleViewModel: viewModel)
        
        // logique de connexion ici, par exemple en appelant une API
        // Validation des champs
        guard !username.isEmpty && !password.isEmpty else {
            errorMessage = "Veuillez remplir tous les champs"
            return
        }
        let loggin = await authentificationIntent.login(pseudo: username, password: password)
        if (loggin == true)
        {
            debugPrint("Youpi")
            isLoggedIn = true
        }
        else
        {
            debugPrint(":(")
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

