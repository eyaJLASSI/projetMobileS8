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
    case failedEncode
    case failedUpdateBenevole
    case failedUpload
    
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
        case .failedEncode:
            return "Failed to encode benevole"
        case .failedUpdateBenevole:
            return "Failed to update benevole"
        case .failedUpload:
            return "Failed to upload benevole"
        case .failedThrow:
            return "Failed to get benevole, method throwed"
        }
    }
}
