//
//  File.swift
//  
//
//  Created by etud on 18/03/2024.
//

import Foundation

class EnvironmentHelper {
    // Permet de récupérer n'importe quelle valeur de Environment à partir d'une clé.
    private static func getEnvironmentValue(forKey key: String) -> String? {
        guard let plist = Bundle.main.path(forResource: "Environment", ofType:"plist"),
              let dict = NSDictionary(contentsOfFile: plist) as? [String: AnyObject]
        else {
            return nil
        }
        return dict[key] as? String
    }
    
    // Donne l'url de l'api
    static func getApi() -> String? {
        if let api = EnvironmentHelper.getEnvironmentValue(forKey: "api_back")
        {
            return api
        }
        else
        {
            debugPrint("FAILED TO GET API URL")
            return nil
        }
    }
}
