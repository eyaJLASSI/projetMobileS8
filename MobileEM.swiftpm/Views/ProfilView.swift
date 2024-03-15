//
//  SwiftUIView.swift
//  
//
//  Created by etud on 15/03/2024.
//

import SwiftUI

struct UserProfile {
    let username: String
    let email: String
    let phoneNumber: String
}

struct ProfileView: View {
    let user: UserProfile
    
    var body: some View {
        VStack {
            Text("Profil de \(user.username)")
                .font(.title)
                .padding()
            
            Text("Nom: \(user.username)")
            Text("Prenom: \(user.email)")
            Text("Email: \(user.email)")
            Text("Pseudo: \(user.email)")
            Text("téléphone: \(user.phoneNumber)")
            Text("Association: \(user.phoneNumber)")
                
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserProfile(username: "UtilisateurTest", email: "utilisateur@test.com", phoneNumber: "1234")
        return ProfileView(user: user)
    }
}


