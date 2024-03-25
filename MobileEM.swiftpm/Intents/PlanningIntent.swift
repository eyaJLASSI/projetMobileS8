//
//  PlanningIntent.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation
import SwiftUI

public struct PlanningIntent
{
    @ObservedObject private var planningViewModel : PlanningViewModel
    
    init(planningViewModel : PlanningViewModel)
    {
        self.planningViewModel = planningViewModel
    }
    
    func getPlanning(idF: Int) async -> Bool
    {
        let planningService = PlanningService()
        
        let result = await planningService.getPlanning(idF: idF)

        switch (result)
        {
        case .success(let planning):
            
            planningViewModel.nombrePlaceTotal = planning!.nombrePlaceTotal
            planningViewModel.postes = planning!.postes
            planningViewModel.espaces = planning!.espaces
            planningViewModel.creneaux = planning!.creneaux
            planningViewModel.inscriptions = planning!.inscriptions
            // Ajouter les inscriptions au view model
            planningViewModel.state = .loaded
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
}
