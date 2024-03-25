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
    var posteId: Int
    
    init(espaceVM : EspaceViewModel){
        self.idEspace = espaceVM.idEspace
        self.libelleEspace = espaceVM.libelleEspace
        self.isAnimation = espaceVM.isAnimation
        self.posteId = espaceVM.posteId
    }
    
    static func == (lhs: EspaceDTO, rhf: EspaceDTO) -> Bool {
        return
            lhs.idEspace      == rhf.idEspace      &&
            lhs.libelleEspace == rhf.libelleEspace &&
            lhs.isAnimation   == rhf.isAnimation   &&
            lhs.posteId       == rhf.posteId
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(idEspace)
        hasher.combine(libelleEspace)
        hasher.combine(isAnimation)
        hasher.combine(posteId)
    }
    
    var description: String
    {
        return """
    idEspace      : \(idEspace)
    libelleEspace : \(libelleEspace)
    isAnimation   : \(isAnimation)
    posteId       : \(posteId)
    """
    }
    
}
