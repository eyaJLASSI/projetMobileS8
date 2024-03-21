//
//  NombrePlaceDTO.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation

class NombrePlaceDTO : Decodable, CustomStringConvertible {
    
    init(nbPlaces : Int)
    {
        self.nbPlaces = nbPlaces
    }
    
    var nbPlaces : Int
    
    var description: String
    {
        return """
    nbPlaces : \(nbPlaces)
    """
    }
}
