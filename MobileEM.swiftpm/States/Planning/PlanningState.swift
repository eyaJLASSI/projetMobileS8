//
//  PlanningState.swift
//  
//
//  Created by etud on 21/03/2024.
//
import Foundation
import SwiftUI

enum PlanningState : CustomStringConvertible
{
    case ready
    case loaded(
        creneaux     : [CreneauDTO],
        espaces      : [EspaceDTO],
        candidatures : [CandidatureDTO],
        inscriptions : [InscriptionDTO],
        postes       : [PosteDTO],
        nombrePlaces : [Two<Int, Int>: Int]
    )
    case inscrit(inscription : InscriptionDTO)
    case desinscrit(inscription: Int)
    case candidater(candidature : [CandidatureDTO])
    case decandidater(idCandidature: Int)
    
    // permet de transformer l'objet case en en string
    var description: String
    {
        switch self
        {
        case .ready:
            return "inscription ready"
        case .loaded:
            return "Planning loaded!"
        case .inscrit(_):
            return "Inscrit !"
        case .desinscrit(_):
            return "Desinscrit !"
        case .candidater(_):
            return "Candidater"
        case .decandidater(_):
            return "Candidater"
        }
    }
}
