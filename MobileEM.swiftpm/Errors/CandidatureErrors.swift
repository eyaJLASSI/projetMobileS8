//
//  CandidatureErrors.swift
//  
//
//  Created by etud on 22/03/2024.
//

import Foundation

enum CandidatureErrors : Error, CustomStringConvertible{
    case failedUrl
    case failedGetCandidature
    case failedGetAllCandidature
    case failedDecode
    case failedThrow
    
    var description: String
    {
        switch self
        {
        case .failedUrl:
            return "Failed to create url"
        case .failedGetCandidature:
            return "Failed to get candidature"
        case .failedGetAllCandidature:
            return "Failed to get all candidatures"
        case .failedDecode:
            return "Failed to decode candidature"
        case .failedThrow:
            return "Failed to get candidature, method throwed"
        }
    }
}
