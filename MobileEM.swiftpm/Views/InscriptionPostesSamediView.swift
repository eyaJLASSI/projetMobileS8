import SwiftUI

struct InscriptionPostesSamediView: View {
    var creneau: String
    
    @State var postesSamedi = ["Cuisine", "Accueil", "Animation Esplanade G1", "Ménage"]
    @State var dispoPostes = [4,4,14,0]
    
    var body: some View {
        VStack{
            NavigationView{
                VStack{
                    Text("Samedi")
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
                            ForEach(0..<postesSamedi.count, id: \.self) {index in
                                HStack{
                                    Text(self.postesSamedi[index])
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
