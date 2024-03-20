//
//  File.swift
//  
//
//  Created by etud on 18/03/2024.
//

import Foundation

class BenevoleService {
    var api : String
    private func getBenevoleByPseudoUrl(pseudo : String) -> String
    {
        "users?pseudo=\(pseudo)"
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
    
    public func getUserByPseudo(pseudo: String) async -> Result<BenevoleDTO?, Error>
    {
        // Concatener l'host avec l'uri
        guard let getBenevole = URL(string: "\(self.api)\(self.getBenevoleByPseudoUrl(pseudo: pseudo))")
        else
        {
            return .failure(BenevoleErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: getBenevole)
        request.httpMethod = "Get"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                guard let decoded : BenevoleDTO = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(BenevoleErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(BenevoleErrors.failedGetBenevole)
            }
        }
        catch
        {
            return .failure(AuthErrors.failedUpload)
        }
    }
}
