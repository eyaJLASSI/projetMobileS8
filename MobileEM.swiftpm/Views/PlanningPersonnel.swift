import SwiftUI

struct PlanningPersonnelView: View {
    @ObservedObject var sinscrireVM : SinscrireViewModel
    
    let pseudo : String
    
    let creneauxSamedi = ["8h - 11h","11h - 14h","14h - 17h","17h - 20h"]
    
    let creneauxDimanche = ["8h - 11h","11h - 14h","14h - 17h","17h - 20h"]
    
    @State var postesSamedi = ["Cuisine", "Accueil", "Animation Esplanade G1", "Ménage"]
    
    @State var postesDimanche = ["Cuisine", "Accueil", "Vide", "Ménage"]
    
    var body: some View {
        let inscriptionPosteIntent = InscriptionPosteIntent(sinscrireViewModel: sinscrireVM)
        
        VStack{
            HStack{
                Text("Planning Personnel")
                    .font(.title)
                    .padding(40)
            }
            ScrollView{
                Text("Samedi")
                    .font(.title3)
                ForEach(0..<creneauxSamedi.count, id: \.self) {index in
                    HStack{
                            Text(self.creneauxSamedi[index])
                                .padding(10)
                        Divider()
                        if(self.postesSamedi[index] != "Vide"){
                            Text(self.postesSamedi[index])
                            
                            Spacer()
                            Button(action: {
                                print("Supprime")
                            }){
                                Image(systemName: "trash")
                            }
                            .padding(10)
                        } else {
                            Spacer()
                        }
                    }                  
                    Divider()
                }
                Spacer(minLength: 70)
                Text("Dimanche")
                    .font(.title3)
                ForEach(0..<creneauxDimanche.count, id: \.self) {index in
                    HStack{
                        Text(self.creneauxDimanche[index])
                            .padding(10)
                        Divider()
                        if(self.postesDimanche[index] != "Vide"){
                            Text(self.postesDimanche[index])
                            
                            Spacer()
                            Button(action: {
                                print("Supprime")
                            }){
                                Image(systemName: "trash")
                            }
                            .padding(10)
                        } else {
                            Spacer()
                        }
                    }                  
                    Divider()
                }
            }
        }
        .onAppear {
            // Call your function here
            Task {
                // Perform your setup tasks or fetch data here
                debugPrint("Fetching data...")
                
                var result = await inscriptionPosteIntent.getInscriptionsByPseudo(pseudo: pseudo)
                
                if (result)
                {
                    debugPrint("Wihii")
                    debugPrint(sinscrireVM.inscriptions.count)
                }
                else
                {
                    debugPrint(":c")
                }
            }
        }
    }
}


struct PlanningPersonnelView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningPersonnelView(sinscrireVM: SinscrireViewModel(inscriptionDTOs: []), pseudo: "blipbloup")
    }
}
