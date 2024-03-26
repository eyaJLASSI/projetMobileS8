//
//  AssociationViewModel.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class AssociationViewModel : ObservableObject, Hashable, Identifiable {
    static func == (lhs: AssociationViewModel, rhs: AssociationViewModel) -> Bool {
        return lhs.idA == rhs.idA
    }
    
    
    var observers : [ViewModelObserver] = []
    
    @Published var idA : Int
    
    @Published var nomAssociation : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }

    init(AssociationDTO : AssociationDTO){
        self.idA = AssociationDTO.idA
        self.nomAssociation = AssociationDTO.nomAssociation
        
    }
    
    init(){
        self.idA=0 //A voir l'initialisation, doutes
        self.nomAssociation=""
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.idA)
    }
    
    
    func register(obs: ViewModelObserver){
            self.observers.append(obs)
        }
    
}
