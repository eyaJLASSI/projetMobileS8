//
//  File.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class AssociationDTO : Decodable, Encodable, Equatable {
    
    var idA : Int
    var nomAssociation : String
    
    init(associationVM : AssociationViewModel ){
        self.idA            = associationVM.idA
        self.nomAssociation = associationVM.nomAssociation

    }
    
    static func == (lhs: AssociationDTO, rhf: AssociationDTO) -> Bool {
        return
        lhs.idA == rhf.idA &&
        lhs.nomAssociation == rhf.nomAssociation
    }
    
}
