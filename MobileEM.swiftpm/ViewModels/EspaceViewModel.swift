//
//  File 2.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class EspaceViewModel : ObservableObject, Hashable, Identifiable {
    static func == (lhs: EspaceViewModel, rhs: EspaceViewModel) -> Bool {
        return lhs.idEspace == rhs.idEspace
    }
    
    
    var observers : [ViewModelObserver] = []
    
    @Published var idEspace : Int
    @Published var isAnimation : Bool
    
    @Published var libelleEspace : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }

    init(EspaceDTO : EspaceDTO){
        self.idEspace = EspaceDTO.idEspace
        self.libelleEspace = EspaceDTO.libelleEspace
        self.isAnimation = EspaceDTO.isAnimation

    }
    
    init(){
        self.idEspace=0 //A voir l'initialisation, doutes
        self.libelleEspace=""
        self.isAnimation=false
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.idEspace)
    }
    
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
    @Published var state : EspaceState = .ready
    {
        didSet
        {
            switch state
            {
                case .ready:
                    debugPrint("view model : ready")
                case .loaded :
                    debugPrint("view model : espace found")
            }
        }
    }

}
