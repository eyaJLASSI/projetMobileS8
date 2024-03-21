import SwiftUI

struct InscriptionPostesDimancheView: View {
    var creneau: String
    
    @State var postesDimanche = ["Cuisine", "Accueil", "Ménage"]
    @State var dispoPostes = [4,4,6]
    
    var body: some View {
        VStack{
            NavigationView{
                VStack{
                    Text("Dimanche")
                        .font(.title)
                        .padding(20) //changer padding
                    Text(creneau)
                        .font(.title2)
                        .padding(10)
                    
                    Button(action: {
                        print("inscription flexible") //remplacer par inscription flexible
                    }, label: {
                        Text("Flexible") 
                    })
                    Spacer()
                    VStack{
                        ScrollView{
                            Divider()
                            ForEach(0..<postesDimanche.count, id: \.self) {index in
                                HStack{
                                    Text(self.postesDimanche[index])
                                        .padding(10)
                                    Divider()
                                    Spacer()
                                    Button(action: {
                                        if(self.dispoPostes[index] > 0){
                                            print("Inscription") //remplacer par vraie inscription
                                        }
                                    }){
                                        Text(String(self.dispoPostes[index]))
                                    }
                                    Spacer()
                                }                  
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}
