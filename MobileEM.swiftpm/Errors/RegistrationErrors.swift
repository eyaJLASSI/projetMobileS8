//
//  RegistrationErrors.swift
//
//
//  Created by etud on 19/03/2024.
//

import SwiftUI
import Foundation

enum RegistrationErrors : Error, CustomStringConvertible{
    case failedUrl
    case failedRegister(errorCode: Int, json: String)
    case failedEncode
    case failedUpload
    case failedDecode
    
    var description: String
    {
        switch self
        {
        case .failedUrl:
            return "Failed to create URL Object"
        case .failedRegister(let errorCode, let json):
            return "Failed to register, error code \(errorCode), json content \(json)"
        case .failedEncode:
            return "Failed to encode registrationDTO object to JSON"
        case .failedUpload:
            return "Failed to send request"
        case .failedDecode:
            return "Failed to decode response"
        }
    }
}
