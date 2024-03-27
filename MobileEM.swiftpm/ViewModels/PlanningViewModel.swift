//
//  PlanningViewModel.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation

class PlanningViewModel : ObservableObject, Hashable, Identifiable {
    
    static func == (lhs: PlanningViewModel, rhs: PlanningViewModel) -> Bool {
        return
        lhs.inscriptions == rhs.inscriptions &&
        lhs.candidatures == rhs.candidatures &&
        lhs.postes == rhs.postes &&
        lhs.espaces == rhs.espaces &&
        lhs.creneaux == rhs.creneaux &&
        lhs.nombrePlaceTotal == rhs.nombrePlaceTotal
    }
    
    
    var observers : [ViewModelObserver] = []
    
    @Published var creneaux : [CreneauDTO]{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var espaces : [EspaceDTO]{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var postes : [PosteDTO]{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var inscriptions : [InscriptionDTO]{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var candidatures : [CandidatureDTO]{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var nombrePlaceTotal : [Two<Int, Int>:Int]{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }

    init(
        creneaux         : [CreneauDTO],
        candidatures     : [CandidatureDTO],
        espaces          : [EspaceDTO],
        inscriptions     : [InscriptionDTO],
        postes           : [PosteDTO],
        nombrePlaceTotal : [Two<Int, Int>: Int]
    ) {
        self.inscriptions     = inscriptions
        self.candidatures     = candidatures
        self.creneaux         = creneaux
        self.espaces          = espaces
        self.postes           = postes
        self.nombrePlaceTotal = nombrePlaceTotal
    }
    
    init(
        plannning         : PlanningDTO
    ) {
        self.inscriptions     = plannning.inscriptions
        self.candidatures     = plannning.candidatures
        self.creneaux         = plannning.creneaux
        self.espaces          = plannning.espaces
        self.postes           = plannning.postes
        self.nombrePlaceTotal = plannning.nombrePlaceTotal
    }
    
    init(){
        self.nombrePlaceTotal = [:]
        self.candidatures = []
        self.inscriptions = []
        self.creneaux = []
        self.espaces = []
        self.postes = []
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.inscriptions)
        hasher.combine(self.candidatures)
        hasher.combine(self.postes)
        hasher.combine(self.creneaux)
        hasher.combine(self.espaces)
        hasher.combine(self.nombrePlaceTotal)
    }
    
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
    @Published var state : PlanningState = .ready
    {
        didSet
        {
            switch state
            {
                case .ready:
                    debugPrint("view model : ready")
                case .loaded(
                    let creneaux,
                    let espaces,
                    let candidatures,
                    let inscriptions,
                    let postes,
                    let nombrePlaceTotal
                ):
                    self.creneaux = creneaux
                    self.espaces  = espaces
                    self.candidatures = candidatures
                    self.inscriptions = inscriptions
                    self.postes = postes
                    self.nombrePlaceTotal = nombrePlaceTotal
                case .inscrit(let inscription):
                    inscriptions.append(inscription)
                case .desinscrit(let idInscription):
                    inscriptions = inscriptions
                        .filter { $0.id != idInscription }
                case .candidater(let candidatures):
                    for candidature in candidatures
                    {
                        self.candidatures.append(candidature)
                    }
                case .decandidater(let idCandidature):
                    self.candidatures = self.candidatures.filter { $0.id != idCandidature }
            }
        }
    }

}
