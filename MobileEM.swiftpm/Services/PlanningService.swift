//
//  File.swift
//  
//
//  Created by etud on 21/03/2024.
//

import Foundation

class PlanningService {
    
    // Contient l'url de l'api
    var api: String
    
    private func getNombrePlaceUrl(creneauId : Int, espaceId: Int) -> String
    {
        // Ici on fix le festival en attendant de pouvoir le choisir avec une liste déroulante.
        return "places?creneauId=\(creneauId)&espaceId=\(espaceId)"
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
    
    public func getPlanning(idF: Int) async -> Result<PlanningDTO?, Error>
    {
        var creneauService      = CreneauService()
        var espaceService       = EspaceService()
        var posteService        = PosteService()
        var inscriptionsService = InscriptionPosteService()
        
        var creneauxResult     = await creneauService.getAllCreneaux(idF: idF)
        var espacesResult      = await espaceService.getAllEspaces(idF: idF)
        var postesResult       = await posteService.getAllPostes(idF: idF)
        var inscriptionsResult = await inscriptionsService.getAllInscriptions(idF: idF)
        
        if case let .failure(error) = creneauxResult {
            debugPrint(error)
            return .failure(CreneauErrors.failedGetAllCreneaux)
        }
        
        if case let .failure(error) = espacesResult {
            debugPrint(error)
            return .failure(EspaceErrors.failedGetAllEspaces)
        }
        
        if case let .failure(error) = postesResult {
            debugPrint(error)
            return .failure(PosteErrors.failedGetAllPostes)
        }
        
        if case let .failure(error) = inscriptionsResult {
            debugPrint(error)
            return .failure(InscriptionPosteErrors.failedGetAllInscritption)
        }
        
        
        var nombrePlaceTotal : [Two<Int, Int>: Int] = [:]
        
        guard case let .success(foundCreneaux) = creneauxResult,
              case let .success(foundEspaces) = espacesResult,
              case let .success(foundPostes) = postesResult,
              case let .success(foundInscriptions) = inscriptionsResult else {
            // Gérer les échecs des résultats
            return .failure(PlanningError.failedCreate)
        }

        // Recupérer pour chaque espace et creneau le nombre de place
        for espace in foundEspaces {
            for creneau in foundCreneaux {
                let nbPlace = await getNombrePlaceByCreneauAndEspace(creneauId: creneau.idC, espaceId: espace.idEspace)
                let key: Two<Int, Int> = Two(values: (creneau.idC, espace.idEspace))
                nombrePlaceTotal[key] = nbPlace
            }
        }

        return .success(PlanningDTO(creneaux: foundCreneaux, espaces: foundEspaces, inscriptions: foundInscriptions, postes: foundPostes, nombrePlaceTotal: nombrePlaceTotal))
    }
    
    public func getNombrePlaceByCreneauAndEspace(creneauId: Int, espaceId: Int) async -> Int
    {
        // Concatener l'host avec l'uri
        guard let getNombrePlaceUrl = URL(string: "\(api)\(getNombrePlaceUrl(creneauId: creneauId, espaceId: espaceId))")
        else
        {
            return 0
        }
        
        // Creer une requête Post
        var request = URLRequest(url: getNombrePlaceUrl)
        request.httpMethod = "Get"
        
        do
        {
            // Envoyer la requete, avec en content le json encodé
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpresponse = response as! HTTPURLResponse // le bon type

            if (httpresponse.statusCode == 200)
            {
                guard let decoded : NombrePlaceDTO = await JSONHelper.decodeOne(data: data)
                else
                {
                    return 0
                }
                
                return decoded.nbPlaces
            }
            else
            {
                return 0
            }
        }
        catch
        {
            return 0
        }
    }
}

