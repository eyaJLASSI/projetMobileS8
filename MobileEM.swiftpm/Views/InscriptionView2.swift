//
//  SwiftUIView.swift
//  
//
//  Created by etud on 20/03/2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var association: String = ""
    @State private var phoneNumber: String = ""
    @State private var chercheUnLogement: Bool = false
    @State private var isVegetarian: Bool = false
    @State private var tshirtSize = 0
    let tshirtSizes = ["S", "M", "L"]
    @State private var isRegistered = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Prénom", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Nom", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Pseudo", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Mot de passe", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Association", text: $association)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Numéro de téléphone", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Text("Cherche un logement ?")
                        .font(.headline)
                        .padding(.bottom, 4)
                    Spacer()
                    Toggle("", isOn: $chercheUnLogement)
                }
                .padding()

                HStack {
                    Text("Végétarien ?")
                        .font(.headline)
                        .padding(.bottom, 4)
                    Spacer()
                    Toggle("", isOn: $isVegetarian)
                }
                .padding()

                HStack {
                    Text("Taille du t-shirt")
                        .font(.headline)
                        .padding(.bottom, 4)
                    Spacer()
                    Picker(selection: $tshirtSize, label: Text("")) {
                        ForEach(0 ..< tshirtSizes.count) {
                            Text(self.tshirtSizes[$0])
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding()

                
                .alert(isPresented: $isRegistered) {
                    Alert(title: Text("Inscription réussie"), message: Text("Vous êtes inscrit avec succès!"), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
        }
        .navigationBarTitle("Inscription")
    }

    private func signup() {
        // Ajoutez ici la logique d'inscription, par exemple en appelant une fonction dans votre ViewModel
        // Après l'inscription réussie, vous pouvez définir la variable `isRegistered` sur true pour afficher l'alerte
        isRegistered = true
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

