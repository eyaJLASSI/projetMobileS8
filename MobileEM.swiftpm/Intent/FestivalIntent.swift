import Foundation
import SwiftUI

//State Festival
enum FestivalState {
    case ready
    case error
    case loadingFestivals
    case loadedFestivals([FestivalModel])
}

struct FestivalIntent {
    
    
    @ObservedObject private var model : FestivalViewModel
    
    init(model: FestivalViewModel){
        self.model = model
    }
    
   
    
    func getFestival() async {
        self.model.state = .loadingFestivals
        
        guard let url = URL(string: "https://festival-jeu-mtp-419077cc35e8.herokuapp.com/festivals") else {
             
            return
        }
        do{
            
            let (data, response) = try await URLSession.shared.data(from: url)
             
             
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                
                 
                debugPrint("\(sdata)")
                guard let decoded : [FestivalModel] = await JSONHelper.decode(data: data) else{
                     
                    return
                }
                
                 
                model.state = .loadedFestivals(decoded)
                
            }
            else{
                debugPrint("error \(httpresponse.statusCode):\(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
            }
        }
        catch{
            debugPrint("bad request")
        }
    }
    func getFestivalbyid(id:Int) async{
        self.model.state = .loadingFestivals
        guard let url = URL(string: "https://festival-jeu-mtp-419077cc35e8.herokuapp.com/festival/\(id)") else {
             
            return
        }
        do{
            
            let (data, response) = try await URLSession.shared.data(from: url)
             
             
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                
                 
                debugPrint("\(sdata)")
                guard let decoded : [FestivalModel] = await JSONHelper.decode(data: data) else{
                     
                    return
                }
                
                 
                model.state = .loadedFestivals(decoded)
                
            }
            else{
                debugPrint("error \(httpresponse.statusCode):\(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
            }
        }
        catch{
            debugPrint("bad request")
        }
    }
    
    func updateFestival(id:Int,festival: FestivalModel) async {
        
        do {
            guard let url=URL(string: "https://festival-jeu-mtp-419077cc35e8.herokuapp.com/festival/\(id)") else {
                print("bad URL")
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            // append a value to a field
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // set (replace) a value to a field
            guard let encoded = await JSONHelper.encode(data: festival) else {
                print(" pb encodage")
                return
            }
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let sdata = String(data: data, encoding: .utf8)!
            debugPrint(request.httpMethod)
        } catch {
            debugPrint("probleme de update")
        }
    }
}
