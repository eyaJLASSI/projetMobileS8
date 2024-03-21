//
//  CreneauService.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class CreneauService {
    var api : String
    private func getCreneauByIdUrl(idC : Int) -> String
    {
        "creneau/\(idC)"
    }
    
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
    
    public func getCreneauById(idC: Int) async -> Result<CreneauDTO?, Error>
    {
        // Concatener l'host avec l'uri
        guard let getCreneau = URL(string: "\(api)\(getCreneauByIdUrl(idC: idC))")
        else
        {
            return .failure(CreneauErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: getCreneau)
        request.httpMethod = "Get"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                guard let decoded : CreneauDTO = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(CreneauErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(CreneauErrors.failedGetCreneau)
            }
        }
        catch
        {
            return .failure(AuthErrors.failedUpload)
        }
    }
    
    private func getAllCreneauByIdUrl(idF : Int) -> String
    {
        "creneaux/\(idF)"
    }
    
    public func getAllCreneaux(idF: Int) async -> Result<[CreneauDTO], Error> {
        // Concatener l'host avec l'uri
        guard let getAllCreneauxURL = URL(string: "\(api)\(getAllCreneauByIdUrl(idF: idF))") else {
            return .failure(CreneauErrors.failedUrl)
        }
        
        // Créer une requête Get
        var request = URLRequest(url: getAllCreneauxURL)
        request.httpMethod = "GET"
        
        do {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type
            
            
            if httpresponse.statusCode == 200 {
                guard let decoded: [CreneauDTO] = await JSONHelper.decodeOne(data: data) else {
                    return .failure(CreneauErrors.failedDecode)
                }
                
                return .success(decoded)
            } else {
                return .failure(CreneauErrors.failedGetAllCreneaux)
            }
        } catch {
            return .failure(error)
        }
    }
    
}

