//
//  CandidatureIntent.swift
//  
//
//  Created by etud on 24/03/2024.
//

import Foundation
import SwiftUI

public struct CandidatureIntent
{
    @ObservedObject private var candidatureViewModel : CandidaterViewModel
    
    init(candidatureViewModel : CandidaterViewModel)
    {
        self.candidatureViewModel = candidatureViewModel
    }
    
    func getCandidaturesByPseudo(pseudo: String) async -> Bool
    {
        let candidatureService = CandidatureService()
        
        let result = await candidatureService.getCandidatureWithAllInfosByPseudo(pseudo: pseudo)

        switch (result)
        {
        case .success(let candidatures):
            // Ajouter les candidatures au view model
            debugPrint(candidatures)
            candidatureViewModel.candidatures = candidatures
            candidatureViewModel.state = .loaded(candidatures)
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
}
