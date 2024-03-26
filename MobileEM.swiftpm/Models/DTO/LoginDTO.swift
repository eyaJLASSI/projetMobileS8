//
//  LoginDto.swift
//  
//
//  Created by etud on 15/03/2024.
//

import Foundation

class LoginDto : Encodable
{
    var pseudo  : String
    var password: String
    
    init(username: String, password: String) {
        self.pseudo   = username
        self.password = password
    }
}

