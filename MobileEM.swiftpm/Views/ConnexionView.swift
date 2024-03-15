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

    
    var body: some View {
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
                // Action à exécuter lorsque le bouton est appuyé
                self.login()
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
        .padding()
    }
    
    func login() {
        // logique de connexion ici, par exemple en appelant une API
        // Validation des champs
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

