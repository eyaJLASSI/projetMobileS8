//
//  CandidatureState.swift
//  
//
//  Created by etud on 22/03/2024.
//

import Foundation
import SwiftUI

enum CandidatureState : CustomStringConvertible
{
    case ready
    case loaded([CandidatureWithAllInfosDTO])
    
    // permet de transformer l'objet case en en string
    var description: String
    {
        switch self
        {
        case .ready:
            return "candidature ready"
        case .loaded(let candidatures):
            return "\(candidatures.count) candidature found"
        }
    }
}
