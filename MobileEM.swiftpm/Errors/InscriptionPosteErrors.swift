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
    case failedGetAllCandidatures
    case failedSinscrire
    case failedSeDesinscire
    case failedDecode
    case failedThrow
    
    var description: String
    {
        switch self
        {
        case .failedUrl:
            return "Failed to create url"
        case .failedGetAllCandidatures:
            return "Failed to fet all candidatures"
        case .failedGetInscritption:
            return "Failed to get inscriptions"
        case .failedGetAllInscritption:
            return "Failed to get all inscriptions"
        case .failedSinscrire:
            return "Failed to register user"
        case .failedDecode:
            return "Failed to decode benevole"
        case .failedSeDesinscire:
            return "Failed to unregister"
        case .failedThrow:
            return "Failed to get benevole, method throwed"
        }
    }
}
