//
//  CandidatureService.swift
//  
//
//  Created by etud on 24/03/2024.
//

import Foundation

class CandidatureService
{
    // Contient l'url de l'api
    var api: String
    
    private func getCandidaturesByPseudoUrl(pseudo : String) -> String
    {
        // Ici on fix le festival en attendant de pouvoir le choisir avec une liste déroulante.
        return "candidature/\(pseudo)/2"
    }
    
    private func getAllCandidaturesUrl(idF : Int) -> String
    {
        // Ici on fixe le festival en attendant de pouvoir le choisir avec une liste déroulante.
        return "candidatures/\(idF)"
    }
    
    private func candidaterUrl(pseudo: String, creneauId: Int, idF: Int) -> String
    {
        // Ici on fixe le festival en attendant de pouvoir le choisir avec une liste déroulante.
        return "candidature_V2/\(pseudo)/\(creneauId)/\(idF)"
    }
    
    private func decandidaterUrl(idCandidature : Int) -> String
    {
        // Ici on fixe le festival en attendant de pouvoir le choisir avec une liste déroulante.
        return "candidature/\(idCandidature)/"
    }
    
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
    
    public func getCandidatureWithAllInfosByPseudo(pseudo: String) async -> Result<[CandidatureWithAllInfosDTO], Error>
    {
        // Creer un tableau vide de [InscriptionWithAllInfosDTO]
        var candidatureWithAllInfosDTOArray : [CandidatureWithAllInfosDTO] = []
        
        // Appeler getInscriptionsByPseudo
        var result = await getCandidaturesByPseudo(pseudo: pseudo)
        var candidatures : [CandidatureDTO] = []
        
        if case let .failure(error) = result {
            debugPrint(error)
            return .failure(CandidatureErrors.failedGetCandidature)
        }
        
        if case let .success(foundCand) = result {
            candidatures = foundCand
            debugPrint("\(candidatures.count) candidatures trouvés")
        }

        
        // Appeler pour chaque candidature getCreneauById
        // Appeler pour chaque candidature getEspaceById
        var creneauService = CreneauService()
        var espaceService = EspaceService()
        for foundCandidature in candidatures
        {
            var creneau = await creneauService.getCreneauById(idC: foundCandidature.creneauId)
            var espace = await espaceService.getEspaceById(idEspace: foundCandidature.espaceId)

            if case let .success(foundCreneau) = creneau {
                if case let .success(foundEspace) = espace {
                    var candidatureWithAllInfosDTO = CandidatureWithAllInfosDTO(candidatureDto: foundCandidature, creneauDto: foundCreneau!, espaceDto: foundEspace!)
                    
                    candidatureWithAllInfosDTOArray.append(candidatureWithAllInfosDTO)
                }
            }
            
            if case let .failure(error) = creneau {
                debugPrint("Failed to get creneau for creneau id \(foundCandidature.creneauId). \(error)")
                continue
            }
            
            if case let .failure(error) = espace {
                debugPrint("Failed to get espace for espace id \(foundCandidature.espaceId). \(error)")
                continue
            }
        }
        
        // Creer pour la candidature, le creneau et l'espace courant, un CandidatureWithAllInfosDTO, et l'ajouter au tableua du début.
        return .success(candidatureWithAllInfosDTOArray)
    }
    
    public func getCandidaturesByPseudo(pseudo: String) async -> Result<[CandidatureDTO], Error>
    {
        
        // Concatener l'host avec l'uri
        guard let getCandidaturesUrl = URL(string: "\(self.api)\(getCandidaturesByPseudoUrl(pseudo: pseudo))")
        else
        {
            return .failure(CandidatureErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: getCandidaturesUrl)
        request.httpMethod = "Get"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                
                guard let decoded : [CandidatureDTO] = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(CandidatureErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(CandidatureErrors.failedGetCandidature)
            }
        }
        catch
        {
            debugPrint("Failed to get candidatures. Errors : \(error)")
            return .failure(CandidatureErrors.failedThrow)
        }
    }
    
    public func getAllCandidatures(idF: Int) async -> Result<[CandidatureDTO], Error>
    {
        
        // Concatener l'host avec l'uri
        guard let getAllCandidaturesUrl = URL(string: "\(self.api)\(getAllCandidaturesUrl(idF: idF))")
        else
        {
            return .failure(CandidatureErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: getAllCandidaturesUrl)
        request.httpMethod = "Get"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                
                guard let decoded : [CandidatureDTO] = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(CandidatureErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(CandidatureErrors.failedGetCandidature)
            }
        }
        catch
        {
            debugPrint("Failed to get all candidatures. Errors : \(error)")
            return .failure(CandidatureErrors.failedThrow)
        }
    }
    
    public func candidater(pseudo: String, creneauId: Int, idF: Int) async -> Result<[CandidatureDTO], Error>
    {
        
        // Concatener l'host avec l'uri
        guard let candidaterUrl = URL(string: "\(self.api)\(candidaterUrl(pseudo: pseudo, creneauId: creneauId, idF: idF))")
        else
        {
            return .failure(CandidatureErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: candidaterUrl)
        request.httpMethod = "Post"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON brut : \(jsonString)")
            } else {
                print("Impossible de convertir les données en chaîne de caractères.")
            }
            
            if (httpresponse.statusCode == 200)
            {
                
                guard let decoded : [CandidatureDTO] = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(CandidatureErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(CandidatureErrors.failedGetCandidature)
            }
        }
        catch
        {
            debugPrint("Failed to get all candidatures. Errors : \(error)")
            return .failure(CandidatureErrors.failedThrow)
        }
    }
    
    public func decandidater(idCandidature : Int) async -> Result<Bool, Error>
    {
        
        // Concatener l'host avec l'uri
        guard let decandidaterUrl = URL(string: "\(self.api)\(decandidaterUrl(idCandidature: idCandidature))")
        else
        {
            return .failure(CandidatureErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: decandidaterUrl)
        request.httpMethod = "Delete"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type
            
            if (httpresponse.statusCode == 200)
            {
                
                return .success(true)
            }
            else
            {
                return .failure(CandidatureErrors.failedGetCandidature)
            }
        }
        catch
        {
            debugPrint("Failed to get all candidatures. Errors : \(error)")
            return .failure(CandidatureErrors.failedThrow)
        }
    }
}
