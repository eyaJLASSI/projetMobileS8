//
//  File.swift
//  
//
//  Created by etud on 15/03/2024.
//

import Foundation

class AuthManager {
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // Logique de connexion ici
        // Par exemple, appel à une API pour vérifier les informations d'identification
        // Appeler la completion avec true si la connexion réussit, sinon false
        let success = true // Exemple, la connexion réussit toujours
        completion(success)
    }
}
