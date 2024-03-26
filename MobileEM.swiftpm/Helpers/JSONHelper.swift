//
//  JSONHelper.swift
//  
//
//  Created by etud on 15/03/2024.
//

import Foundation
import SwiftUI

struct JSONHelper{
    
    static func decodeMany<T: Decodable>(data: Data) async -> [T]?{
        let decoder = JSONDecoder() // création d'un décodeur
        if let decoded = try? decoder.decode([T].self, from: data){
            return decoded
        }else{
            debugPrint("json could not be decoded from data")
        }
        return nil
    }
    
    
    static func decodeOne<T: Decodable>(data: Data) async -> T? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            debugPrint("Error decoding JSON: \(error)")
            return nil
        }
    }

    
    static func encode<T : Encodable>(data : T) async -> Data?{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let jsonData = try? encoder.encode(data) else {
            //debugPrint(JSONError.JsonEncodingFailed)
            return nil
        }
        return jsonData
    }
    
    
}
