//
//  InscriptionPoste.swift
//  
//
//  Created by etud on 20/03/2024.
//

import Foundation

class InscriptionPosteService
{
    // Contient l'url de l'api
    var api: String
    
    private func getInscriptionsByPseudoUrl(pseudo : String) -> String
    {
        // Ici on fix le festival en attendant de pouvoir le choisir avec une liste déroulante.
        return "inscriptions/\(pseudo)/2"
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
    
    public func getInscriptionWithAllInfosByPseudo(pseudo: String) async -> Result<[InscriptionWithAllInfosDTO], Error>
    {
        // Creer un tableau vide de [InscriptionWithAllInfosDTO]
        var inscriptionWithAllInfosDTOArray : [InscriptionWithAllInfosDTO] = []
        
        // Appeler getInscriptionsByPseudo
        var result = await getInscriptionsByPseudo(pseudo: pseudo)
        var inscriptions : [InscriptionDTO] = []
        
        if case let .failure(error) = result {
            debugPrint(error)
            return .failure(InscriptionPosteErrors.failedGetInscritption)
        }
        
        if case let .success(foundInsc) = result {
            inscriptions = foundInsc
            debugPrint("\(inscriptions.count) inscriptions trouvés")
        }

        
        // Appeler pour chaque inscription getCreneauById
        // Appeler pour chaque inscription getEspaceById
        var creneauService = CreneauService()
        var espaceService = EspaceService()
        for foundInscription in inscriptions
        {
            var creneau = await creneauService.getCreneauById(idC: foundInscription.creneauId)
            var espace = await espaceService.getEspaceById(idEspace: foundInscription.espaceId)

            if case let .success(foundCreneau) = creneau {
                if case let .success(foundEspace) = espace {
                    var inscriptionWithAllInfosDTO = InscriptionWithAllInfosDTO(inscriptionDto: foundInscription, creneauDto: foundCreneau!, espaceDto: foundEspace!)
                    
                    inscriptionWithAllInfosDTOArray.append(inscriptionWithAllInfosDTO)
                }
            }
            
            if case let .failure(error) = creneau {
                debugPrint("Failed to get creneau for creneau id \(foundInscription.creneauId). \(error)")
                continue
            }
            
            if case let .failure(error) = espace {
                debugPrint("Failed to get espace for espace id \(foundInscription.espaceId). \(error)")
                continue
            }
        }
        
        // Creer pour l'inscrption, le creneau et l'espace courant, un InscriptionWithAllInfosDTO, et l'ajouter au tableua du début.
        return .success(inscriptionWithAllInfosDTOArray)
    }
    
    public func getInscriptionsByPseudo(pseudo: String) async -> Result<[InscriptionDTO], Error>
    {
        
        // Concatener l'host avec l'uri
        guard let getInscriptionsUrl = URL(string: "\(self.api)\(getInscriptionsByPseudoUrl(pseudo: pseudo))")
        else
        {
            return .failure(InscriptionPosteErrors.failedUrl)
        }
        
        // Creer une requête Post
        var request = URLRequest(url: getInscriptionsUrl)
        request.httpMethod = "Get"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                
                guard let decoded : [InscriptionDTO] = await JSONHelper.decodeOne(data: data)
                else
                {
                    return .failure(InscriptionPosteErrors.failedDecode)
                }
                
                return .success(decoded)
            }
            else
            {
                return .failure(InscriptionPosteErrors.failedGetInscritption)
            }
        }
        catch
        {
            debugPrint("Failed to get inscriptions. Errors : \(error)")
            return .failure(InscriptionPosteErrors.failedThrow)
        }
    }
}
