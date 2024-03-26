//
//  BenevoleService.swift
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
    
    private func updateBenevoleUrl(pseudo: String) -> String {
        "benevole/\(pseudo)"
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
    
    public func updateBenevole(pseudo: String, updatedBenevole: BenevoleModifDTO) async -> Result<Void, Error> {
            // Concatener l'host avec l'uri
            guard let updateBenevoleURL = URL(string: "\(self.api)\(self.updateBenevoleUrl(pseudo: pseudo))") else {
                return .failure(BenevoleErrors.failedUrl)
            }
            
            // Créer une requête PUT
            var putRequest = URLRequest(url: updateBenevoleURL)
            putRequest.httpMethod = "Put"
            // permet de préciser le type du contenu envoyé
            putRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            // Encoder les données du profil mis à jour en JSON et les ajouter à la requête
            do {
                let encoder = JSONEncoder()
                let json = try encoder.encode(updatedBenevole)
                if let jsonString = String(data: json, encoding: .utf8) {
                    debugPrint("Json envoyé : \(jsonString)")
                }
                putRequest.httpBody = json
            } catch {
                return .failure(BenevoleErrors.failedEncode)
            }
        
            
            // Envoyer la requête PUT
            do {
                let (data, response) = try await URLSession.shared.data(for: putRequest)
                let httpResponse = response as! HTTPURLResponse // le bon type
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON recu brut : \(jsonString)")
                } else {
                    print("Impossible de convertir les données en chaîne de caractères.")
                }
                if (httpResponse.statusCode == 200) {
                    return .success(())
                } else {
                    return .failure(BenevoleErrors.failedUpdateBenevole)
                }
            } catch {
                return .failure(BenevoleErrors.failedUpload)
            }
        }
    
}
