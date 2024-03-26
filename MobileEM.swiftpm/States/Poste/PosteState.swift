//
//  PosteState.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

enum PosteState : CustomStringConvertible
{
    case ready
    case loaded(PosteDTO)
    
    // permet de transformer l'objet case en en string
    var description: String
    {
        switch self
        {
        case .ready:
            return "poste ready"
        case .loaded(_):
            return "poste found"
        }
    }
}
