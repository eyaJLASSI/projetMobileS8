//
//  File.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class EspaceDTO : Decodable, Encodable, Equatable {
    
    var idEspace : Int
    var libelleEspace : String
    var isAnimation : Bool

    
    init(espaceVM : EspaceViewModel ){
        self.idEspace = espaceVM.idEspace
        self.libelleEspace = espaceVM.libelleEspace
        self.isAnimation = espaceVM.isAnimation

    }
    
    static func == (lhs: EspaceDTO, rhf: EspaceDTO) -> Bool {
        return
            lhs.idEspace      == rhf.idEspace      &&
            lhs.libelleEspace == rhf.libelleEspace &&
            lhs.isAnimation   == rhf.isAnimation

    }
    
}
