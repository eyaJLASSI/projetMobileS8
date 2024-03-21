//
//  PosteErrors.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

enum PosteErrors : Error, CustomStringConvertible{
    case failedUrl
    case failedGetPoste
    case failedDecode
    case failedThrow
    
    var description: String
    {
        switch self
        {
        case .failedUrl:
            return "Failed to create url"
        case .failedGetPoste:
            return "Failed to get poste"
        case .failedDecode:
            return "Failed to decode poste"
        case .failedThrow:
            return "Failed to get poste, method throwed"
        }
    }
}
