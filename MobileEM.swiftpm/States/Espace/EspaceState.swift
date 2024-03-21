//
//  EspaceState.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

enum EspaceState : CustomStringConvertible
{
    case ready
    case loaded(EspaceDTO)
    
    // permet de transformer l'objet case en en string
    var description: String
    {
        switch self
        {
        case .ready:
            return "espace ready"
        case .loaded(_):
            return "espace found"
        }
    }
}
