//
//  File 2.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class CreneauViewModel : ObservableObject, Hashable, Identifiable {
    static func == (lhs: CreneauViewModel, rhs: CreneauViewModel) -> Bool {
        return lhs.idC == rhs.idC
    }
    
    
    var observers : [ViewModelObserver] = []
    
    @Published var idC : Int
    
    @Published var heureDebut : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }
    
    @Published var heureFin : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }
    
    @Published var jourCreneau : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }
    
    @Published var idF : Int{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }
    
    

    init(CreneauDTO : CreneauDTO){
        self.idC = CreneauDTO.idC
        self.heureDebut = CreneauDTO.heureDebut
        self.heureFin = CreneauDTO.heureFin
        self.jourCreneau = CreneauDTO.jourCreneau
        self.idF = CreneauDTO.idF

        
    }
    
    init(){
        self.idC=0 //A voir l'initialisation, doutes
        self.heureDebut=""
        self.heureFin=""
        self.jourCreneau=""
        self.idF=2 // A voir aussi

    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.idC)
    }
    
    
    func register(obs: ViewModelObserver){
            self.observers.append(obs)
        }
    
}
