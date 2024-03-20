//
//  RegistrationDTO.swift
//
//
//  Created by etud on 19/03/2024.
//

import Foundation

class RegistrationDTO : Decodable, Encodable, Equatable {
    
    var prenom : String = ""
    var nom : String = ""
    var pseudo : String = ""
    var email : String = ""
    var password : String = ""
    var numTel : String = ""
    var chercheLogement: Bool
    var taille: String
    var vegetarian: Bool
    
    init(registrationVM : RegistrationViewModel ){
        self.prenom = registrationVM.prenom
        self.nom = registrationVM.nom
        self.pseudo = registrationVM.pseudo
        self.email = registrationVM.email
        self.password = registrationVM.password
        self.numTel = registrationVM.numTel
        self.chercheLogement = registrationVM.chercheLogement
        self.taille = registrationVM.taille
        self.vegetarian = registrationVM.vegetarian
    }
    
    init(
        prenom : String,
        nom : String,
        pseudo : String,
        email : String,
        password : String,
        numTel : String,
        chercheLogement : Bool,
        taille : String,
        vegetarian : Bool
    )
    {
        self.prenom = prenom
        self.nom = nom
        self.pseudo = pseudo
        self.email = email
        self.password = password
        self.numTel = numTel
        self.chercheLogement = chercheLogement
        self.taille = taille
        self.vegetarian = vegetarian
    }
    static func == (lhs: RegistrationDTO, rhf: RegistrationDTO) -> Bool {
        return
        lhs.prenom == rhf.prenom &&
        lhs.nom == rhf.nom &&
        lhs.pseudo == rhf.pseudo &&
        lhs.email == rhf.email &&
        lhs.password == rhf.password &&
        lhs.numTel == rhf.numTel &&
        lhs.chercheLogement == rhf.chercheLogement &&
        lhs.taille == rhf.taille &&
        lhs.vegetarian == rhf.vegetarian 
    }
    
}
