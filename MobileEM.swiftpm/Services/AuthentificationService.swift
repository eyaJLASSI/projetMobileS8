//
//  File.swift
//  
//
//  Created by etud on 18/03/2024.
//

import Foundation

class AuthentificationService
{
    // Contient l'url de l'api
    var api: String
    
    let loginApi: String        = "login"
    let registrationApi: String = "registration"
    
    // Constructeur
    init()
    {
        if let api = EnvironmentHelper.getApi()
        {
            self.api = api
        }
        else
        {
            self.api = ""
        }
    }
    
    // Login
    public func login(pseudo: String, password: String) async -> Result<AuthDTO, Error>
    {
        
        // Concatener l'host avec l'uri
        debugPrint("\(self.api)\(self.loginApi)")
        guard let loginUrl = URL(string: "\(self.api)\(self.loginApi)")
        else
        {
            return .failure(AuthErrors.unknown)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: loginUrl)
        request.httpMethod = "Post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // On va creer un DTO de login, pour pouvoir le transformer en JSON et l'utiliser dans la requête post
        // L'object LoginDto hérite de Encodable, c'est pour ça que je peux l'utiliser avec cette methode
        let loginDto : LoginDto = LoginDto(username: pseudo, password: password)
        guard let json : Data = await JSONHelper.encode(data: loginDto)
        else
        {
            return .failure(AuthErrors.failedEncode)
        }
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.upload(for: request, from: json)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                guard let decoded : AuthDTO = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(AuthErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(AuthErrors.failedLogin)
            }
        }
        catch
        {
            debugPrint("Login failed : \(error)")
            return .failure(AuthErrors.failedUpload)
        }
    }
    
    // Register
    public func register(
        prenom : String,
        nom : String,
        pseudo : String,
        email : String,
        password : String,
        numTel : String,
        association: String
    ) async -> Result<AuthDTO, Error>
    {
        // Concatener l'host avec l'uri
        guard let registerApi = URL(string: "\(self.api)\(self.registrationApi)")
        else
        {
            return .failure(RegistrationErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: registerApi)
        request.httpMethod = "Post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // On va creer un DTO de login, pour pouvoir le transformer en JSON et l'utiliser dans la requête post
        // L'object LoginDto hérite de Encodable, c'est pour ça que je peux l'utiliser avec cette methode
        let registerDto : RegistrationDTO = RegistrationDTO(prenom: prenom, nom: nom, pseudo: pseudo, email: email, password: password, numTel: numTel, association: association)
        guard let json : Data = await JSONHelper.encode(data: registerDto)
        else
        {
            return .failure(RegistrationErrors.failedEncode)
        }
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.upload(for: request, from: json)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                guard let decoded : AuthDTO = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(RegistrationErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(RegistrationErrors.failedRegister)
            }
        }
        catch
        {
            debugPrint("Regiter failed : \(error)")
            return .failure(RegistrationErrors.failedUpload)
        }
    }
}
