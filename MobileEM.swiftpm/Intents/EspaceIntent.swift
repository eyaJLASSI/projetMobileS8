//
//  EspaceIntent.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

public struct EspaceIntent
{
    @ObservedObject private var espaceViewModel : EspaceViewModel
    
    init(espaceViewModel : EspaceViewModel)
    {
        self.espaceViewModel = espaceViewModel
    }
    
    func getEspaceById(idEspace: Int) async -> Bool
    {
        let espaceService = EspaceService()
        
        let result = await espaceService.getEspaceById(idEspace: idEspace)

        
        switch (result)
        {
        case .success(let espace):
            // Ajouter les inscriptions au view model
            debugPrint(espace!)
            espaceViewModel.state = .loaded(espace!)
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
}
