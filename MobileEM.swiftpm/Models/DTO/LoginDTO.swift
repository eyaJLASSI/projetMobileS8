//
//  File.swift
//  
//
//  Created by etud on 15/03/2024.
//

import Foundation

class LoginDto : Encodable
{
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

