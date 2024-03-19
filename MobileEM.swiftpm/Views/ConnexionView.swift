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
    @ObservedObject private var viewModel = LoginViewModel()
    @State private var isShowingInscriptionView = false //State pour gérer la navigation

    
    var body: some View {
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
                .padding()
            
            SecureField("Mot de passe", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                // Action à exécuter lorsque le bouton est appuyé
                self.login()
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
    }
    
    func login() {
        // logique de connexion ici, par exemple en appelant une API
        // Validation des champs
        debugPrint("bllblbl")
        guard !username.isEmpty && !password.isEmpty else {
            errorMessage = "Veuillez remplir tous les champs"
            return
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

