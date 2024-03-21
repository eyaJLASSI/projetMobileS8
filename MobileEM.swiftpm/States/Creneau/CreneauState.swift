//
//  CreneauState.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

enum CreneauState : CustomStringConvertible
{
    case ready
    case loaded(CreneauDTO)
    
    // permet de transformer l'objet case en en string
    var description: String
    {
        switch self
        {
        case .ready:
            return "creneau ready"
        case .loaded(_):
            return "creneau found"
        }
    }
}
