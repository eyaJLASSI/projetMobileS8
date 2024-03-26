//
//  BenevoleIntent.swift
//  
//
//  Created by etud on 18/03/2024.
//

import Foundation
import SwiftUI

struct BenevoleIntent {
    
    @ObservedObject private var benevoleViewModel : BenevoleViewModel
    private var benevoleService : BenevoleService = BenevoleService()
    
    init(benevole : BenevoleViewModel)
    {
        self.benevoleViewModel = benevole
    }
    
    func updateBenevole(pseudo: String, updatedBenevole: BenevoleModifDTO) async -> Bool
    {
        let benevoleService = BenevoleService()
        
        let result = await benevoleService.updateBenevole(pseudo: pseudo, updatedBenevole: updatedBenevole)
        
        switch (result)
        {
        case .success():
            benevoleViewModel.state = .updated
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
}
