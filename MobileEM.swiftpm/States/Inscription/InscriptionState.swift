//
//  InscriptionState.swift
//  
//
//  Created by etud on 20/03/2024.
//
import Foundation
import SwiftUI

enum InscriptionState : CustomStringConvertible
{
    case ready
    case loaded([InscriptionDTO])
    
    // permet de transformer l'objet case en en string
    var description: String
    {
        switch self
        {
        case .ready:
            return "inscription ready"
        case .loaded(let inscriptions):
            return "\(inscriptions.count) inscription found"
        }
    }
}
