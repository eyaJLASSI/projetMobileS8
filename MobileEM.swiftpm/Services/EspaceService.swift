//
//  EspaceService.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation

class EspaceService {
    
    var api : String
    
    private func getEspaceByIdUrl(idEspace : Int) -> String
    {
        "espace/\(idEspace)"
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
    
    public func getEspaceById(idEspace: Int) async -> Result<EspaceDTO?, Error>
    {
        // Concatener l'host avec l'uri
        guard let getEspace = URL(string: "\(api)\(getEspaceByIdUrl(idEspace: idEspace))")
        else
        {
            return .failure(EspaceErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: getEspace)
        request.httpMethod = "Get"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                guard let decoded : EspaceDTO = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(EspaceErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(EspaceErrors.failedGetEspace)
            }
        }
        catch
        {
            return .failure(AuthErrors.failedUpload)
        }
    }
    
    private func getAllEspaceByIdUrl(idF : Int) -> String
    {
        "espaces/\(idF)"
    }
    
    public func getAllEspaces(idF: Int) async -> Result<[EspaceDTO], Error> {
        // Concatener l'host avec l'uri
        guard let getAllEspacesURL = URL(string: "\(api)\(getAllEspaceByIdUrl(idF: idF))") else {
            return .failure(EspaceErrors.failedUrl)
        }
        
        // Créer une requête Get
        var request = URLRequest(url: getAllEspacesURL)
        request.httpMethod = "GET"
        
        do {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type
            
            
            if httpresponse.statusCode == 200 {
                guard let decoded: [EspaceDTO] = await JSONHelper.decodeOne(data: data) else {
                    return .failure(EspaceErrors.failedDecode)
                }
                
                return .success(decoded)
            } else {
                return .failure(EspaceErrors.failedGetEspace)
            }
        } catch {
            return .failure(error)
        }
    }
    
}


