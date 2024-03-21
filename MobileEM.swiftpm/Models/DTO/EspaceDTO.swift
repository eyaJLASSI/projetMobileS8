//
//  EspaceDTO.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class EspaceDTO : Decodable, Encodable, Equatable, Hashable, CustomStringConvertible {
    
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
    
    func hash(into hasher: inout Hasher){
        hasher.combine(idEspace)
        hasher.combine(libelleEspace)
        hasher.combine(isAnimation)
    }
    
    var description: String
    {
        return """
    idEspace      : \(idEspace)
    libelleEspace : \(libelleEspace)
    isAnimation   : \(isAnimation)
    libelleEspace : \(libelleEspace)
    isAnimation   : \(isAnimation)
    """
    }
    
}
