//
//  InscriptionWithAllInfosDTO.swift
//  
//
//  Created by etud on 20/03/2024.
//

import Foundation

class InscriptionWithAllInfosDTO {
    
    var inscriptionDto : InscriptionDTO
    var creneauDto : CreneauDTO
    var espaceDto : EspaceDTO

    
    init(inscriptionDto: InscriptionDTO, creneauDto: CreneauDTO, espaceDto: EspaceDTO) {
        self.inscriptionDto = inscriptionDto
        self.creneauDto = creneauDto
        self.espaceDto = espaceDto
    }
    
}
