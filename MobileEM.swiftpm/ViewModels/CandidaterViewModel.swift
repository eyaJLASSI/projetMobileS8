//
//  CandidaterViewModel.swift
//  
//
//  Created by etud on 22/03/2024.
//

import Foundation

class CandidaterViewModel : ObservableObject, Hashable, Identifiable {
    
    var observers : [ViewModelObserver] = []
    
    
    @Published var candidatures : [CandidatureWithAllInfosDTO] {
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }

    init(candidatureDTOs : [CandidatureWithAllInfosDTO]){
        candidatures = candidatureDTOs
    }
    
    init() {
        candidatures = []
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.candidatures)
    }
    
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
    static func == (lhs: CandidaterViewModel, rhs: CandidaterViewModel) -> Bool {
        return lhs.candidatures == rhs.candidatures
    }
    
    @Published var state : CandidatureState = .ready
    {
        didSet
        {
            switch state
            {
                case .ready:
                    debugPrint("view model : ready")
                case .loaded(let candidatures):
                    debugPrint("view model : loggedin")
                    self.candidatures = candidatures
            }
        }
    }
    
}
