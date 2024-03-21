//
//  SinscrireViewModel.swift
//  
//
//  Created by etud on 20/03/2024.
//

import Foundation


class SinscrireViewModel : ObservableObject, Hashable, Identifiable {
    
    var observers : [ViewModelObserver] = []
    
    
    @Published var inscriptions : [InscriptionWithAllInfosDTO] {
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }

    init(inscriptionDTOs : [InscriptionWithAllInfosDTO]){
        inscriptions = inscriptionDTOs
    }
    
    init() {
        inscriptions = []
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.inscriptions)
    }
    
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
    static func == (lhs: SinscrireViewModel, rhs: SinscrireViewModel) -> Bool {
        return lhs.inscriptions == rhs.inscriptions
    }
    
    @Published var state : InscriptionState = .ready
    {
        didSet
        {
            switch state
            {
                case .ready:
                    debugPrint("view model : ready")
                case .loaded(let inscriptions):
                    debugPrint("view model : loggedin")
                    self.inscriptions = inscriptions
            }
        }
    }
    
}
