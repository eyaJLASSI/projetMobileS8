//
//  PosteViewModel.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class PosteViewModel : ObservableObject, Hashable, Identifiable {
    static func == (lhs: PosteViewModel, rhs: PosteViewModel) -> Bool {
        return lhs.idP == rhs.idP &&
        lhs.libellePoste == rhs.libellePoste
    }
    
    
    var observers : [ViewModelObserver] = []
    
    @Published var idP : Int
    
    @Published var libellePoste : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }

    init(PosteDTO : PosteDTO){
        self.idP = PosteDTO.idP
        self.libellePoste = PosteDTO.libellePoste
        
    }
    
    init(){
        self.idP=0 //A voir l'initialisation, doutes
        self.libellePoste=""
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.idP)
    }
    
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
    @Published var state : PosteState = .ready
    {
        didSet
        {
            switch state
            {
                case .ready:
                    debugPrint("view model : ready")
                case .loaded :
                    debugPrint("view model : poste found")
            }
        }
    }
    
}
