//
//  File.swift
//  
//
//  Created by etud on 18/03/2024.
//

import Foundation
import SwiftUI

struct BenevoleIntent {
    
    @ObservedObject private var model : BenevoleViewModel
    private var benevoleService : BenevoleService = BenevoleService()
    
    init(benevole : BenevoleViewModel)
    {
        self.model = benevole
    }
}
