//
//  SwiftUIView.swift
//
//
//  Created by etud on 13/03/2024.
//

import SwiftUI

/*
 struct SwiftUIView: View {
 var body: some View {
 Text("Connexion")
 }
 }
 
 struct SwiftUIView_Previews: PreviewProvider {
 static var previews: some View {
 SwiftUIView()
 }
 }
 */
struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
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
        // Logique de connexion ici
        print("Nom d'utilisateur: \(username), Mot de passe: \(password)")
        
        // logique de connexion ici, par exemple en appelant une API
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

