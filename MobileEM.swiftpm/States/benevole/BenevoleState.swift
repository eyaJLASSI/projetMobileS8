//
//  BenevoleState.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation
import SwiftUI

enum BenevoleState : CustomStringConvertible
{
    case ready
    case loggedIn(BenevoleDTO)
    case authFailed(Error)
    
    // permet de transformer l'objet case en en string
    var description: String
    {
        switch self
        {
        case .ready:
            return "ready"
        case .authFailed(let error):
            return "auth failed \(error)"
        case .loggedIn(_):
            return "User logged in"
        }
    }
}
