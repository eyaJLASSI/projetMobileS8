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
            
            planningViewModel.state = .loaded(
                creneaux: planning!.creneaux,
                espaces: planning!.espaces,
                candidatures: planning!.candidatures,
                inscriptions: planning!.inscriptions,
                postes: planning!.postes,
                nombrePlaces: planning!.nombrePlaceTotal
            )
            // mettre à jour le state du view model à loaded
            return true
        case .failure(let failure):
            debugPrint(failure)
            return false
        }
    }
}
