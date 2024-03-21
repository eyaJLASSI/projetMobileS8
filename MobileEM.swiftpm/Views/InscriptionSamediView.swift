import SwiftUI

struct InscriptionSamediView: View {
    let creneauxSamedi = ["8h - 11h","11h - 14h","14h - 17h","17h - 20h"]
    
    var body: some View {
        VStack{
            NavigationView{
                VStack{
                    Text("Planning Inscription")
                        .font(.title)
                        .padding(.top, 40)
                    
                    NavigationLink(destination: InscriptionDimancheView()){
                        Text("Vers Dimanche")
                            .padding(.top, 10)
                    }
                    
                    VStack{
                        ScrollView{
                            Text("Samedi")
                                .font(.title3)
                                .padding(20)
                            ForEach(0..<creneauxSamedi.count, id: \.self) {index in
                                HStack{
                                    Text(self.creneauxSamedi[index])
                                        .padding(10)
                                    Divider()
                                    Spacer()
                                    NavigationLink(destination: InscriptionPostesSamediView(creneau: self.creneauxSamedi[index])){
                                        Text("S'inscrire")
                                    }
                                    Spacer()
                                }                  
                                Divider()
                            }
                        }
                    }
                    
                    Spacer()
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: ProfilView()){
                            Image(systemName: "person")
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: PlanningPersonnelView()){
                            Image(systemName: "calendar")
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: InscriptionSamediView()){
                            Image(systemName: "list.bullet.clipboard")
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: ProfilView()){
                            Image(systemName: "hourglass")
                        }
                        Spacer()
                        
                        /*
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
}
