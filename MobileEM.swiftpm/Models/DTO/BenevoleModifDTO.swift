//
//  BenevoleDTO.swift
//
//
//  Created by etud on 17/03/2024.
//

import Foundation

class BenevoleModifDTO : Decodable, Encodable, Equatable {
    
    var pseudo          : String
    var nom             : String
    var prenom          : String
    var email           : String
    var numTel          : String
    var chercheLogement : Bool
    var taille          : String
    var vegetarian      : Bool
    
    init(benevoleVM : BenevoleViewModel ){
        self.pseudo          = benevoleVM.pseudo
        self.nom             = benevoleVM.nom
        self.prenom          = benevoleVM.prenom
        self.email           = benevoleVM.email
        self.numTel          = benevoleVM.numTel
        self.chercheLogement = benevoleVM.chercheLogement
        self.taille          = benevoleVM.taille
        self.vegetarian      = benevoleVM.vegetarien

    }
    
    // implementation de la methode ==
    // https://developer.apple.com/documentation/swift/equatable
    static func == (lhs: BenevoleModifDTO, rhf: BenevoleModifDTO) -> Bool {
        return
            lhs.pseudo          == rhf.pseudo          &&
            lhs.nom             == rhf.nom             &&
            lhs.prenom          == rhf.nom             &&
            lhs.email           == rhf.email           &&
            lhs.numTel          == rhf.numTel          &&
            lhs.chercheLogement == rhf.chercheLogement &&
            lhs.taille          == rhf.taille          &&
            lhs.vegetarian      == rhf.vegetarian
        
    }
    
    
}
