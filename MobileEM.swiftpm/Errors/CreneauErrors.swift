//
//  CreneauErrors.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

enum CreneauErrors : Error, CustomStringConvertible{
    case failedUrl
    case failedGetCreneau
    case failedDecode
    case failedThrow
    case failedGetAllCreneaux

    
    var description: String
    {
        switch self
        {
        case .failedUrl:
            return "Failed to create url"
        case .failedGetCreneau:
            return "Failed to get creneau"
        case .failedDecode:
            return "Failed to decode creneau"
        case .failedThrow:
            return "Failed to get creneau, method throwed"
        case .failedGetAllCreneaux:
            return "Failed to get All creneaux"
        }
    }
}
