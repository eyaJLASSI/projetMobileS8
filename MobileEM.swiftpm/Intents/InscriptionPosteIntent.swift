//
//  InscriptionPosteIntent.swift
//  
//
//  Created by etud on 20/03/2024.
//

import Foundation
import SwiftUI

public struct InscriptionPosteIntent
{
    @ObservedObject private var sinscrireViewModel : SinscrireViewModel
    
    init(sinscrireViewModel : SinscrireViewModel)
    {
        self.sinscrireViewModel = sinscrireViewModel
    }
    
    func getInscriptionsByPseudo(pseudo: String) async -> Bool
    {
        let inscriptionPosteService = InscriptionPosteService()
        
        let result = await inscriptionPosteService.getInscriptionWithAllInfosByPseudo(pseudo: pseudo)

        switch (result)
        {
        case .success(let inscriptionPostes):
            // Ajouter les inscriptions au view model
            debugPrint(inscriptionPostes)
            sinscrireViewModel.inscriptions = inscriptionPostes
            sinscrireViewModel.state = .loaded(inscriptionPostes)
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
}
