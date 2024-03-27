//
//  PlanningCandidatureState.swift
//
//
//  Created by etud on 21/03/2024.
//
import Foundation
import SwiftUI

enum PlanningCandidatureState : CustomStringConvertible
{
    case ready
    case loaded(
        creneaux     : [CreneauDTO],
        espaces      : [EspaceDTO],
        candidatures : [CandidatureDTO],
        postes       : [PosteDTO]
    )
    
    // permet de transformer l'objet case en en string
    var description: String
    {
        switch self
        {
        case .ready:
            return "inscription ready"
        case .loaded:
            return "Planning candidateure loaded!"
        }
    }
}
