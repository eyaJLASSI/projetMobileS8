//
//  PosteDTO.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class PosteDTO : Decodable, Encodable, Equatable, Hashable, CustomStringConvertible {
    
    var idP : Int
    var libellePoste : String
    
    init(posteVM : PosteViewModel ){
        self.idP          = posteVM.idP
        self.libellePoste = posteVM.libellePoste

    }
    
    static func == (lhs: PosteDTO, rhf: PosteDTO) -> Bool {
        return
        lhs.idP == rhf.idP &&
        lhs.libellePoste == rhf.libellePoste
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.idP)
        hasher.combine(self.libellePoste)
    }
    
    var description: String
    {
        return """
    idP          : \(idP)
    libellePoste : \(libellePoste)
    """
    }
}
