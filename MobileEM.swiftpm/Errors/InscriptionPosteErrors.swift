//
//  InscriptionPosteService.swift
//  
//
//  Created by etud on 20/03/2024.
//

import Foundation

enum InscriptionPosteErrors : Error, CustomStringConvertible{
    case failedUrl
    case failedGetInscritption
    case failedGetAllInscritption
    case failedDecode
    case failedThrow
    
    var description: String
    {
        switch self
        {
        case .failedUrl:
            return "Failed to create url"
        case .failedGetInscritption:
            return "Failed to get inscriptions"
        case .failedGetAllInscritption:
            return "Failed to get all inscriptions"
        case .failedDecode:
            return "Failed to decode benevole"
        case .failedThrow:
            return "Failed to get benevole, method throwed"
        }
    }
}
