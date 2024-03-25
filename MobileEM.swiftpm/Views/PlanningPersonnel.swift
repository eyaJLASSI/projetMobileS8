import SwiftUI

struct PlanningPersonnelView: View {
    @ObservedObject var sinscrireVM : SinscrireViewModel
    //@ObservedObject var candidaterVM : CandidaterViewModel
    
    let benevoleVM: BenevoleViewModel
    
    let pseudo : String
    
    var samediInscriptions: [InscriptionWithAllInfosDTO] {
        sinscrireVM.inscriptions
            .filter { $0.creneauDto.jourCreneau == "Samedi" }
            .sorted { $0.creneauDto.heureDebut > $1.creneauDto.heureDebut }
    }
    
    var dimancheInscriptions: [InscriptionWithAllInfosDTO] {
        sinscrireVM.inscriptions
            .filter { $0.creneauDto.jourCreneau == "Dimanche" }
            .sorted { $0.creneauDto.heureDebut > $1.creneauDto.heureDebut }
    }
    
    var body: some View {
        let inscriptionPosteIntent = InscriptionPosteIntent(sinscrireViewModel: sinscrireVM)
        
        NavigationView{
            VStack{
                VStack{
                    HStack{
                        Text("Planning Personnel")
                            .font(.title)
                            .padding(40)
                    }
                    ScrollView{
                        Text("Samedi")
                            .font(.title3)
                        ForEach(samediInscriptions, id: \.self) { inscription in
                            HStack{
                                Text("\(inscription.creneauDto.heureDebut) - \(inscription.creneauDto.heureFin)")
                                    .padding(10)
                                Divider()
                                Text(inscription.espaceDto.libelleEspace)
                                
                                Spacer()
                                Button(action: {
                                    print("Supprime")
                                }){
                                    Image(systemName: "trash")
                                }
                                .padding(10)
                            }                  
                            Divider()
                        }
                        Spacer(minLength: 70)
                        Text("Dimanche")
                            .font(.title3)
                        ForEach(dimancheInscriptions, id: \.self) {inscription in
                            HStack{
                                Text("\(inscription.creneauDto.heureDebut) - \(inscription.creneauDto.heureFin)")
                                    .padding(10)
                                Divider()
                                Text(inscription.espaceDto.libelleEspace)
                                
                                Spacer()
                                Button(action: {
                                    print("Supprime")
                                }){
                                    Image(systemName: "trash")
                                }
                                .padding(10)
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
                            //debugPrint("Wihii")
                            //debugPrint(sinscrireVM.inscriptions.count)
                            //for inscription in sinscrireVM.inscriptions
                            //{
                            //    debugPrint("=====================")
                            //    debugPrint(inscription)
                            //    debugPrint("=====================")
                            //}
                        }
                        else
                        {
                            debugPrint(":c")
                        }
                        
                    }
                }
                
                Spacer()
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: ProfileView(benevoleVM: benevoleVM, pseudo: pseudo, sinscrireVM: sinscrireVM)){
                        Image(systemName: "person")
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: PlanningPersonnelView(sinscrireVM: sinscrireVM, benevoleVM: benevoleVM, pseudo: pseudo)){
                        Image(systemName: "calendar")
                    }
                    
                    Spacer()
                    
                    /*
                    NavigationLink(destination: InscriptionSamediView()){
                        Image(systemName: "list.bullet.clipboard")
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: ProfilView()){
                        Image(systemName: "hourglass")
                    }
                    Spacer()
                    
                    
                     NavigationLink(destination: FithView()){
                     Image(systemName: "info.circle")
                     }
                     Spacer()
                     */
                }
                .padding()
                .foregroundColor(.blue)
            }
        }
        .navigationBarHidden(true)
    }
}


struct PlanningPersonnelView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningPersonnelView(sinscrireVM: SinscrireViewModel(inscriptionDTOs: []), benevoleVM: BenevoleViewModel(), pseudo: "blipbloup")
    }
}
