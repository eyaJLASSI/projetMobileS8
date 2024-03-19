import Foundation
class FestivalModel:ObservableObject,Identifiable, Codable{
    var idF : Int
    var annee: Int
    var numEdition: Int

    init(_idF: Int, annee: Int, numEdition: Int){
        self.idF=_idF
        self.annee=annee
        self.numEdition = numEdition    
    }
}
