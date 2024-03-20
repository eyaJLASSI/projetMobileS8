//
//  File.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation
import SwiftUI

enum RegistrationState : CustomStringConvertible
{
    case ready
    case registered(RegistrationDTO)
    case registrationFailed(Error)
    
    var description: String
    {
        switch self
        {
        case .ready:
            return "ready"
        case .registered(let registrationDto):
            return "Registered user \(registrationDto.pseudo)"
        case .registrationFailed(_):
            return "Failed registration"
        }
    }
}
