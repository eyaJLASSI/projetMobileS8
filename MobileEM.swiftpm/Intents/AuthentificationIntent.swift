//
//  AuthentificationIntent.swift
//
//
//  Created by etud on 19/03/2024.
//

import Foundation
import SwiftUI

public struct AuthentificationIntent
{
    @ObservedObject private var benevoleViewModel : BenevoleViewModel
    
    init(benevoleViewModel : BenevoleViewModel)
    {
        self.benevoleViewModel = benevoleViewModel
    }
    
    func login(pseudo: String, password: String) async -> Bool
    {
        let authentificationService = AuthentificationService()
        let benevoleService = BenevoleService()
        
        let result = await authentificationService.login(pseudo: pseudo, password: password)

        switch (result)
        {
        case .success(let token):
            // Token valide
            debugPrint(token.token)
            
        case .failure(let failure):
            debugPrint(failure)
            // Si on pass ici, ca veut dire que le login a échoue.
            // On retourne et la fonction s'arrete ici.
            return false
        }
        
        //tocken valide
        let benevole = await benevoleService.getUserByPseudo(pseudo: pseudo)
        switch benevole
        {
        case .success(let benevole):
            debugPrint("benevole \(benevole?.email ?? "no email")")
            benevoleViewModel.state = .loggedIn(benevole!)
            return true
        case .failure(let error):
            debugPrint(error)
            benevoleViewModel.state = .authFailed(error)
            return false
        }
    }
    
    public func register(
        prenom : String,
        nom : String,
        pseudo : String,
        email : String,
        password : String,
        numTel : String,
        chercheUnLogement: Bool,
        isVegetarian: Bool,
        tshirtSize: String
    ) async -> Bool
    {
        let authentificationService = AuthentificationService()
        let benevoleService = BenevoleService()

        let result = await authentificationService.register(prenom: prenom, nom: nom, pseudo: pseudo, email: email, password: password, numTel: numTel, chercheLogement: chercheUnLogement, taille: tshirtSize, vegetarian: isVegetarian)
        
        switch(result)
        {
        case .success(let token):
            // Token valide
            debugPrint(token.token)
            
        case .failure(let failure):
            debugPrint(failure)
            // Si on pass ici, ca veut dire que le login a échoue.
            // On retourne et la fonction s'arrete ici.
            return false
        }
        
        //tocken valide
        let benevole = await benevoleService.getUserByPseudo(pseudo: pseudo)
        switch benevole
        {
        case .success(let benevole):
            debugPrint("benevole \(benevole?.pseudo ?? "no pseudo")")
            benevoleViewModel.state = .loggedIn(benevole!)
            return true
        case .failure(let error):
            debugPrint(error)
            benevoleViewModel.state = .authFailed(error)
            return false
        }
    }
}
