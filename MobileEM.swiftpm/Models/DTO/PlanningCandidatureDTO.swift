//
//  PlanningCandidatureDTO.swift
//  
//
//  Created by etud on 24/03/2024.
//

import Foundation

class PlanningCandidatureDTO : CustomStringConvertible
{
    init(
        creneaux         : [CreneauDTO],
        espaces          : [EspaceDTO],
        candidatures     : [CandidatureDTO],
        postes           : [PosteDTO]
        //nombrePlaceTotal : [Two<Int, Int>: Int]
    ) {
        self.candidatures     = candidatures
        self.creneaux         = creneaux
        self.espaces          = espaces
        self.postes           = postes
        //self.nombrePlaceTotal = nombrePlaceTotal
    }
    
    var creneaux         : [CreneauDTO]
    var espaces          : [EspaceDTO]
    var candidatures     : [CandidatureDTO]
    var postes           : [PosteDTO]
    //var nombrePlaceTotal : [Two<Int, Int>: Int]
    
    var description: String
    {
        return """
    - Creneaux         :
    \(creneaux)
    - Espaces          :
    \(espaces)
    - Inscriptions     :
    \(candidatures)
    - Postes           :
    \(postes)
    """
    }
}

// Structure pour pouvoir utiliser deux valeurs en temps que clé dans un dictionnaire.
// Autrement (Int, Int) : Int est refusé ...
/*
struct Two<T:Hashable,U:Hashable> : Hashable {
    static func == (lhs: Two<T, U>, rhs: Two<T, U>) -> Bool {
        lhs.values == rhs.values
    }

    let values : (T, U)

    var hashValue : Int {
      get {
          let (a,b) = values
          return a.hashValue &* 31 &+ b.hashValue
      }
    }
}*/
