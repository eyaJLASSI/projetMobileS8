//
//  File.swift
//  
//
//  Created by etud on 18/03/2024.
//

import Foundation

class BenevoleService {
    var api : String
    
    init(){
        if let url = EnvironmentHelper.getApi()
        {
            self.api = url
        }
        else
        {
            self.api = ""
        }
    }
    
    // Inscription
    
    
    // Connexion
    
}
