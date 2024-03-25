//
//  CandidatureDTO.swift
//  
//
//  Created by etud on 22/03/2024.
//

import Foundation

class CandidatureDTO : Decodable, Encodable, Equatable, Hashable, CustomStringConvertible {
    
    let id : Int
    let isAffected: Bool
    let isAccepted: Bool
    let benevolePseudo: String
    // Creer un DTO pour creneau et espace
    // Au lieu d'avoir l'id, on veut le contenu de la table.
    // Pour faire ça, on va appeler l'api dans InscriptionPosteService pour
    // récupérer le creneau et l'espace avec leur id.
    // La suite dans Inscription DTO
    let creneauId: Int
    let espaceId: Int
    let idF: Int
    
    
    init(id:Int, isAffected: Bool, isAccepted: Bool, benevolePseudo: String, creneauId: Int, espaceId: Int, idF: Int) {
        self.id = id
        self.isAffected = isAffected
        self.isAccepted = isAccepted
        self.benevolePseudo = benevolePseudo
        self.creneauId = creneauId
        self.espaceId = espaceId
        self.idF = idF
    }
    
    static func == (lhs: CandidatureDTO, rhs: CandidatureDTO) -> Bool {
        return
        lhs.id == rhs.id &&
        lhs.isAffected == rhs.isAffected &&
        lhs.isAccepted == rhs.isAccepted &&
        lhs.benevolePseudo == rhs.benevolePseudo &&
        lhs.creneauId == rhs.creneauId &&
        lhs.espaceId == rhs.espaceId &&
        lhs.idF == rhs.idF
    }
    
    // Implementing Hashable protocol
    func hash(into hasher: inout Hasher) {
        // Combine the hashes of all properties using the hasher
        hasher.combine(isAffected)
        hasher.combine(isAccepted)
        hasher.combine(benevolePseudo)
        hasher.combine(creneauId)
        hasher.combine(espaceId)
        hasher.combine(idF)
        hasher.combine(id)
    }
    
    var description: String
    {
        return """
    id             : \(id)
    isAffected     : \(isAffected)
    isAccepted     : \(isAccepted)
    benevolePseudo : \(benevolePseudo)
    creneauId      : \(creneauId)
    espaceId       : \(espaceId)
    idF            : \(idF)
    """
    }
    
}

