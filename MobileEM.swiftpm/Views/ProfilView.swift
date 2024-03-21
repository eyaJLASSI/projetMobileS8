//
//  SwiftUIView.swift
//  
//
//  Created by etud on 15/03/2024.
//

import SwiftUI


struct ProfilView: View {
    let benevoleVM: BenevoleViewModel
    
    var body: some View {
        VStack {
            Text("Profil de \(benevoleVM.pseudo)")
                .font(.title)
                .padding()
            
            Text("Nom: \(benevoleVM.nom)")
            Text("Prenom: \(benevoleVM.prenom)")
            Text("Email: \(benevoleVM.email)")
            Text("Pseudo: \(benevoleVM.pseudo)")
            Text("téléphone: \(benevoleVM.numTel)")
                
            
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        let user = BenevoleViewModel()
        return ProfilView(benevoleVM: user)
    }
}


