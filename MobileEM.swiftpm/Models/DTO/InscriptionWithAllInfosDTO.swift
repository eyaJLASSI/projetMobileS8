//
//  InscriptionWithAllInfosDTO.swift
//  
//
//  Created by etud on 20/03/2024.
//

import Foundation

class InscriptionWithAllInfosDTO : Equatable, Hashable, CustomStringConvertible {
    static func == (lhs: InscriptionWithAllInfosDTO, rhs: InscriptionWithAllInfosDTO) -> Bool {
        lhs.inscriptionDto == rhs.inscriptionDto &&
        lhs.creneauDto == rhs.creneauDto &&
        lhs.espaceDto == rhs.espaceDto
    }
    
    
    var inscriptionDto : InscriptionDTO
    var creneauDto : CreneauDTO
    var espaceDto : EspaceDTO

    
    init(inscriptionDto: InscriptionDTO, creneauDto: CreneauDTO, espaceDto: EspaceDTO) {
        self.inscriptionDto = inscriptionDto
        self.creneauDto = creneauDto
        self.espaceDto = espaceDto
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(inscriptionDto)
        hasher.combine(creneauDto)
        hasher.combine(espaceDto)
    }
    
    var description: String
    {
        return """
    inscriptionDto :
    \(inscriptionDto)
    
    creneauDto     :
    \(creneauDto)
    
    espaceDto      :
    \(espaceDto)
    """
    }
}
