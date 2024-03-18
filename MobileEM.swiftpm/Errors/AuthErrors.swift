//
//  AuthErrors.swift
//  
//
//  Created by etud on 18/03/2024.
//

import SwiftUI
import Foundation

enum AuthErrors : Error, CustomStringConvertible{
    case unknown
    case failedEncode
    case failedLogin
    case failedDecode
    case failedUpload
    
    var description: String
    {
        switch self
        {
        case .unknown:
            return "JSONError [unknown error]"
        case .failedEncode:
            return "Failed to encode object to Json"
        case .failedLogin:
            return "Failed to login"
        case .failedDecode:
            return "Failed to decode"
        case .failedUpload:
            return "Failed to send request"
        }
    }
}
