//
//  File.swift
//  
//
//  Created by etud on 15/03/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    private let authManager = AuthManager()
    
    func login(username: String, password: String) {
        authManager.login(username: username, password: password) { success in
            DispatchQueue.main.async {
                self.isLoggedIn = success
            }
        }
    }
}
