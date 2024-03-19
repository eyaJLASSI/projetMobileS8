//
//  File.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class CreneauDTO : Decodable, Encodable, Equatable {
    
    var idC : Int
    var heureDebut : String
    var heureFin : String
    var jourCreneau : String
    var idF : Int

    
    init(creneauVM : CreneauViewModel ){
        self.idC            = creneauVM.idC
        self.heureDebut = creneauVM.heureDebut
        self.heureFin = creneauVM.heureFin
        self.jourCreneau = creneauVM.jourCreneau
        self.idF = creneauVM.idF


    }
    
    static func == (lhs: CreneauDTO, rhf: CreneauDTO) -> Bool {
        return
        lhs.idC == rhf.idC &&
        lhs.heureDebut == rhf.heureDebut &&
        lhs.heureFin == rhf.heureFin &&
        lhs.jourCreneau == rhf.jourCreneau &&
        lhs.idF == rhf.idF

    }
    
}
