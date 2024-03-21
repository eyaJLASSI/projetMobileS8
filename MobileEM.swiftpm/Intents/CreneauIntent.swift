//
//  CreneauIntent.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

public struct CreneauIntent
{
    @ObservedObject private var creneauViewModel : CreneauViewModel
    
    init(creneauViewModel : CreneauViewModel)
    {
        self.creneauViewModel = creneauViewModel
    }
    
    func getCreneauById(idC: Int) async -> Bool
    {
        let creneauService = CreneauService()
        
        let result = await creneauService.getCreneauById(idC: idC)

        
        switch (result)
        {
        case .success(let creneau):
            // Ajouter les inscriptions au view model
            debugPrint(creneau!)
            creneauViewModel.state = .loaded(creneau!)
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
}
