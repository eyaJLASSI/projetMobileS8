//
//  File.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class PosteService {
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
}
