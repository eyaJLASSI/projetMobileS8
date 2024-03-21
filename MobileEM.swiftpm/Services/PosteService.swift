//
//  PosteService.swift
//  
//
//  Created by etud on 19/03/2024.
//

import Foundation


class PosteService {
    var api : String
    private func getPosteByIdUrl(idP : Int) -> String
    {
        "poste/\(idP)"
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
    
    public func getPosteById(idP: Int) async -> Result<PosteDTO?, Error>
    {
        // Concatener l'host avec l'uri
        guard let getPoste = URL(string: "\(api)\(getPosteByIdUrl(idP: idP))")
        else
        {
            return .failure(PosteErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: getPoste)
        request.httpMethod = "Get"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                guard let decoded : PosteDTO = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(PosteErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(PosteErrors.failedGetPoste)
            }
        }
        catch
        {
            return .failure(AuthErrors.failedUpload)
        }
    }
}



