//
//  File.swift
//  
//
//  Created by etud on 17/03/2024.
//

import Foundation

class BenevoleDTO : Decodable, Encodable, Equatable {
    
    var pseudo          : String
    var nom             : String
    var prenom          : String
    var email           : String
    var password        : String
    var numTel          : String
    var chercheLogement : Bool
    var taille          : String
    var vegetarien      : Bool
    
    init(benevoleVM : BenevoleViewModel ){
        self.pseudo          = benevoleVM.pseudo
        self.nom             = benevoleVM.nom
        self.prenom          = benevoleVM.prenom
        self.email           = benevoleVM.email
        self.password        = benevoleVM.password
        self.numTel          = benevoleVM.numTel
        self.chercheLogement = benevoleVM.chercheLogement
        self.taille          = benevoleVM.taille
        self.vegetarien      = benevoleVM.vegetarien

    }
    
    // implementation de la methode ==
    // https://developer.apple.com/documentation/swift/equatable
    static func == (lhs: BenevoleDTO, rhf: BenevoleDTO) -> Bool {
        return
            lhs.pseudo          == rhf.pseudo          &&
            lhs.nom             == rhf.nom             &&
            lhs.prenom          == rhf.nom             &&
            lhs.email           == rhf.email           &&
            lhs.password        == rhf.password        &&
            lhs.numTel          == rhf.numTel          &&
            lhs.chercheLogement == rhf.chercheLogement &&
            lhs.taille          == rhf.taille          &&
            lhs.vegetarien      == rhf.vegetarien
        
    }
    
    
}
