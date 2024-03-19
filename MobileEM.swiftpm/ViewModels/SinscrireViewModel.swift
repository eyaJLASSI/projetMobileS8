//
//  File 2.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class SinscrireViewModel : ObservableObject, Hashable, Identifiable {
    static func == (lhs: SinscrireViewModel, rhs: SinscrireViewModel) -> Bool {
        return lhs.isAffected == rhs.isAffected
    }
    
    
    var observers : [ViewModelObserver] = []
    
    @Published var isAffected : Bool
    @Published var isAccepted : Bool
    @Published var creneauId : Int
    @Published var espaceId : Int
    @Published var idF : Int

    
    @Published var benevolePseudo : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }

    init(SinscrireDTO : SinscrireDTO){
        self.isAffected = SinscrireDTO.isAffected
        self.isAccepted = SinscrireDTO.isAccepted
        self.creneauId = SinscrireDTO.creneauId
        self.espaceId = SinscrireDTO.espaceId
        self.idF = SinscrireDTO.idF
        self.benevolePseudo = SinscrireDTO.benevolePseudo

        
    }
    
    init(){
        self.isAffected = true
        self.isAccepted = true
        self.creneauId = 3 // A enlever après
        self.espaceId = 3 // A enlever après
        self.idF = 2 // A voir !!
        self.benevolePseudo = ""

    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.isAccepted)
    }
    
    
    func register(obs: ViewModelObserver){
            self.observers.append(obs)
        }
    
}
