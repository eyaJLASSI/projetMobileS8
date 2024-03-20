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
    var association : String = ""
    
    init(registrationVM : RegistrationViewModel ){
        self.prenom = registrationVM.prenom
        self.nom = registrationVM.nom
        self.pseudo = registrationVM.pseudo
        self.email = registrationVM.email
        self.password = registrationVM.password
        self.numTel = registrationVM.numTel
        self.association = registrationVM.association
    }
    
    init(
        prenom : String,
        nom : String,
        pseudo : String,
        email : String,
        password : String,
        numTel : String,
        association : String
    )
    {
        self.prenom = prenom
        self.nom = nom
        self.pseudo = pseudo
        self.email = email
        self.password = password
        self.numTel = numTel
        self.association = association
    }
    static func == (lhs: RegistrationDTO, rhf: RegistrationDTO) -> Bool {
        return
        lhs.prenom == rhf.prenom &&
        lhs.nom == rhf.nom &&
        lhs.pseudo == rhf.pseudo &&
        lhs.email == rhf.email &&
        lhs.password == rhf.password &&
        lhs.numTel == rhf.numTel &&
        lhs.association == rhf.association
    }
    
}