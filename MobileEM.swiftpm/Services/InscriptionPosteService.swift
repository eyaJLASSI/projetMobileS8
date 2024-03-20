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
    
    public func getInscriptionWithAllInfosByPseudo(idCreneau: String) async -> Result<[InscriptionWithAllInfosDTO], Error>
    {
        // Creer un tableau vide de [InscriptionWithAllInfosDTO]
        
        // Appeler getInscriptionsByPseudo
        
        // Appeler pour chaque inscription getCreneauById
        // Appeler pour chaque inscription getEspaceById
        
        // Creer pour l'inscrption, le creneau et l'espace courant, un InscriptionWithAllInfosDTO, et l'ajouter au tableua du début.
        
        
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
    
    public func getCreneauById(idCreneau: String) async -> Result<[CreneauDTO], Error>
    {
        // TODO
    }
    
    public func getEspaceById(idEspace: String) async -> Result<[EspaceDTO], Error>
    {
        // TODO
    }
    
}
