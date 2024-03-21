//
//  PosteIntent.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

public struct PosteIntent
{
    @ObservedObject private var posteViewModel : PosteViewModel
    
    init(posteViewModel : PosteViewModel)
    {
        self.posteViewModel = posteViewModel
    }
    
    func getPosteById(idP: Int) async -> Bool
    {
        let posteService = PosteService()
        
        let result = await posteService.getPosteById(idP: idP)

        
        switch (result)
        {
        case .success(let poste):
            // Ajouter les inscriptions au view model
            debugPrint(poste)
            posteViewModel.state = .loaded(poste!)
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
    
    
}
