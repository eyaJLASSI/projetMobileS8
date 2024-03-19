//
//  File.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class SinscrireDTO : Decodable, Encodable, Equatable {
    
    let isAffected: Bool
    let isAccepted: Bool
    let benevolePseudo: String
    let creneauId: Int
    let espaceId: Int
    let idF: Int
    
    init(sinscrireVM : SinscrireViewModel ){
        self.isAffected = sinscrireVM.isAffected
        self.isAccepted = sinscrireVM.isAccepted
        self.benevolePseudo = sinscrireVM.benevolePseudo
        self.creneauId = sinscrireVM.creneauId
        self.espaceId = sinscrireVM.espaceId
        self.idF = sinscrireVM.idF


    }
    
    static func == (lhs: SinscrireDTO, rhs: SinscrireDTO) -> Bool {
        return
        lhs.isAffected == rhs.isAffected &&
        lhs.isAccepted == rhs.isAccepted &&
        lhs.benevolePseudo == rhs.benevolePseudo &&
        lhs.creneauId == rhs.creneauId &&
        lhs.espaceId == rhs.espaceId &&
        lhs.idF == rhs.idF
    }
    
}

