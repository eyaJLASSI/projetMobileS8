//
//  AuthErrors.swift
//
//
//  Created by etud on 18/03/2024.
//

import SwiftUI
import Foundation

enum BenevoleErrors : Error, CustomStringConvertible{
    case failedUrl
    case failedGetBenevole
    case failedDecode
    case failedThrow
    
    var description: String
    {
        switch self
        {
        case .failedUrl:
            return "Failed to create url"
        case .failedGetBenevole:
            return "Failed to get benevole"
        case .failedDecode:
            return "Failed to decode benevole"
        case .failedThrow:
            return "Failed to get benevole, method throwed"
        }
    }
}
