//
//  File.swift
//  
//
//  Created by etud on 17/03/2024.
//

import Foundation

class BenevoleDTO : Decodable, Encodable, Equatable {
    
    var pseudo : String
    var nom : String
    var prenom : String
    var email : String
    var password : String
    var numTel : String
    var chercheLogement : Bool
    var taille : String
    var vegetarien : Bool
    
    init(benevoleVM : BenevoleViewModel ){
        self.pseudo = benevoleVM.pseudo
        self.nom = benevoleVM.nom
        self.prenom = benevoleVM.prenom
        self.email = benevoleVM.email
        self.password = benevoleVM.password
        self.numTel = benevoleVM.numTel
        self.chercheLogement = benevoleVM.chercheLogement
        self.taille = benevoleVM.taille
        self.vegetarien = benevoleVM.vegetarien

    }
    
    static func == (lhs: BenevoleDTO, rhs: BenevoleDTO) -> Bool {
        return lhs.pseudo == rhs.pseudo &&
        lhs.nom == rhs.nom &&
        lhs.prenom == rhs.nom &&
        lhs.email == rhs.email &&
        lhs.password == rhs.password &&
        lhs.numTel == rhs.numTel &&
        lhs.chercheLogement == rhs.chercheLogement &&
        lhs.taille == rhs.taille &&
        lhs.vegetarien == rhs.vegetarien
        
    }
    
    static func convertBenevoleDTOsToDisplay(benevolesDTOs : [BenevoleDTO]) -> [BenevoleViewModel]{
            var benevoleViewModelArray : [BenevoleViewModel] = []
            for benevoleDTO in benevolesDTOs {
                let benevoleViewModel = BenevoleViewModel(BenevoleDTO: benevoleDTO)
                benevoleViewModelArray.append(benevoleViewModel)
            }
            return benevoleViewModelArray
        }
    
    
}
