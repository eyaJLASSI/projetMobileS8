//
//  PlanningError.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation

enum PlanningError : Error, CustomStringConvertible{
    case failedCreate

    
    var description: String
    {
        switch self
        {
        case .failedCreate:
            return "Failed to create planning"
        }
    }
}
