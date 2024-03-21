//
//  EspaceErrors.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

enum EspaceErrors : Error, CustomStringConvertible{
    case failedUrl
    case failedGetEspace
    case failedDecode
    case failedThrow
    
    var description: String
    {
        switch self
        {
        case .failedUrl:
            return "Failed to create url"
        case .failedGetEspace:
            return "Failed to get espace"
        case .failedDecode:
            return "Failed to decode espace"
        case .failedThrow:
            return "Failed to get espace, method throwed"
        }
    }
}
