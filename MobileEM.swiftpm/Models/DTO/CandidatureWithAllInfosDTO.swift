//
//  CandidatureWithAllInfosDTO.swift
//  
//
//  Created by etud on 22/03/2024.
//

import Foundation

class CandidatureWithAllInfosDTO : Equatable, Hashable, CustomStringConvertible {
    static func == (lhs: CandidatureWithAllInfosDTO, rhs: CandidatureWithAllInfosDTO) -> Bool {
        lhs.candidatureDto == rhs.candidatureDto &&
        lhs.creneauDto == rhs.creneauDto &&
        lhs.espaceDto == rhs.espaceDto
    }
    
    
    var candidatureDto : CandidatureDTO
    var creneauDto : CreneauDTO
    var espaceDto : EspaceDTO

    
    init(candidatureDto: CandidatureDTO, creneauDto: CreneauDTO, espaceDto: EspaceDTO) {
        self.candidatureDto = candidatureDto
        self.creneauDto = creneauDto
        self.espaceDto = espaceDto
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(candidatureDto)
        hasher.combine(creneauDto)
        hasher.combine(espaceDto)
    }
    
    var description: String
    {
        return """
    inscriptionDto :
    \(candidatureDto)
    
    creneauDto     :
    \(creneauDto)
    
    espaceDto      :
    \(espaceDto)
    """
    }
}
