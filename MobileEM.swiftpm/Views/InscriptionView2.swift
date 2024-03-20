//
//  SwiftUIView.swift
//  
//
//  Created by etud on 20/03/2024.
//

import SwiftUI

struct InscriptionView2: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var association: String = ""
    @State private var phoneNumber: String = ""
    @State private var chercheUnLogement: Bool = false
    @State private var isVegetarian: Bool = false
    @State private var tshirtSize: String=""
    let tshirtSizes = ["S", "M", "L"]
    @State private var isRegistered = false
    let benevoleVM: BenevoleViewModel
    
    var body: some View {
        Text("Inscription")
            .font(.title)
            .padding(40)
        Spacer()
        
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
            
            Button(action: {
                    Task
                    {
                        await self.signup()
                    }
                }) {
                    Text("S'inscrire")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
        }
        .navigationBarTitle("Inscription")
    }

    public func signup() async {
        let authentificationIntent = await AuthentificationIntent(benevoleViewModel: benevoleVM)
        
        let register = await authentificationIntent.register(prenom: firstName, nom: lastName, pseudo: username, email: email, password: password, numTel: phoneNumber, association: association, chercheUnLogement: chercheUnLogement, isVegetarian: isVegetarian ,tshirtSize: tshirtSize )
        if (register == true)
        {
            debugPrint("Youpi")
            isRegistered = true
        }
        else
        {
            debugPrint(":(")
        }
    }
}

struct InscriptionView2_Previews: PreviewProvider {
    static var previews: some View {
        InscriptionView2(benevoleVM: BenevoleViewModel())
    }
}

