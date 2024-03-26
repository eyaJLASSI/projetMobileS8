//
//  SinscrireIntent.swift
//  
//
//  Created by etud on 25/03/2024.
//

import Foundation
import SwiftUI

public struct SinscrireIntent
{
    
    @ObservedObject private var planningViewModel : PlanningViewModel
    
    init(planningViewModel : PlanningViewModel)
    {
        self.planningViewModel = planningViewModel
    }
    
    func sinscrire(benevolePseudo: String, creneauId: Int, espaceId: Int, idF: Int) async -> Bool
    {
        let inscriptionPosteService = InscriptionPosteService()
        
        let result = await inscriptionPosteService.sinscrire(benevolePseudo: benevolePseudo, creneauId: creneauId, espaceId: espaceId, idF: idF)
        switch (result)
        {
        case .success(let inscription):
            planningViewModel.inscriptions.append(inscription)
            planningViewModel.state = .loaded
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
    
    func seDesinscrire(idInscription : Int) async -> Bool
    {
        let inscriptionPosteService = InscriptionPosteService()
        
        let result = await inscriptionPosteService.seDesinscrire(idInscription: idInscription)
        switch (result)
        {
        case .success(_):
            planningViewModel.inscriptions = planningViewModel.inscriptions
                .filter { $0.id != idInscription }
            planningViewModel.state = .loaded
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
    
    func candidater(pseudo : String, creneauId : Int, idF: Int) async -> Bool
    {
        let candidaterService = CandidatureService()
        
        let result = await candidaterService.candidater(pseudo: pseudo, creneauId: creneauId, idF: idF)
        
        switch (result)
        {
        case .success(let candidatures):
            for candidature in candidatures
            {
                planningViewModel.candidatures.append(candidature)
            }
            planningViewModel.state = .loaded
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
    
    func decandidater(idCandidature : Int) async -> Bool
    {
        let candidaterService = CandidatureService()
        
        let result = await candidaterService.decandidater(idCandidature: idCandidature)
        
        switch (result)
        {
        case .success(_):
            planningViewModel.candidatures = planningViewModel.candidatures.filter { $0.id != idCandidature }
            planningViewModel.state = .loaded
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
}
