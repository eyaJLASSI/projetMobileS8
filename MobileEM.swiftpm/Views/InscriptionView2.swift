//
//  SwiftUIView.swift
//  
//
//  Created by etud on 20/03/2024.
//

import SwiftUI
import Combine

struct InscriptionView2: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var chercheUnLogement: Bool = false
    @State private var isVegetarian: Bool = false
    
    enum TeeShirtSizes: String, CaseIterable, Identifiable {
        case S, M, L
        var id: Self { self }
    }

    @State private var tshirtSize: TeeShirtSizes = .S
    
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
                    .autocapitalization(.none)
                    .padding()

                TextField("Nom", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()

                TextField("Pseudo", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()

                SecureField("Mot de passe", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()

                //TextField("Association", text: $association)
                //    .textFieldStyle(RoundedBorderTextFieldStyle())
                //    .padding()

                TextField("Numéro de téléphone", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                    .onReceive(Just(phoneNumber)) { newValue in
                        // Check that new char is a number
                        let allowedCharacters = "0123456789"
                        let filtered = newValue.filter
                        {
                            allowedCharacters.contains($0)
                        }
                        if filtered != newValue {
                            self.phoneNumber = filtered
                        }
                        
                        if phoneNumber.count > 10 {
                            phoneNumber = String(phoneNumber.prefix(10))
                        }
                    }

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
                    Picker("Taille du tee-Shirt", selection: $tshirtSize) {
                        ForEach(TeeShirtSizes.allCases) { size in
                            Text(size.rawValue.capitalized)
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
        
        let register = await authentificationIntent.register(prenom: firstName, nom: lastName, pseudo: username, email: email, password: password, numTel: phoneNumber, chercheUnLogement: chercheUnLogement, isVegetarian: isVegetarian ,tshirtSize: tshirtSize.rawValue.capitalized )
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
