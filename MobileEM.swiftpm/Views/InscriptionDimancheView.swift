import SwiftUI

struct InscriptionDimancheView: View {
    
    let creneauxDimanche = ["8h - 11h","11h - 14h","14h - 17h"]
    
    var body: some View {
        VStack{
            NavigationView{
                VStack{
                    Text("Planning Inscription")
                        .font(.title)
                        .padding(.top, 40)
                    
                    NavigationLink(destination: InscriptionSamediView()){
                        Text("Vers Samedi")
                            .padding(.top, 10)
                    }
                    
                    VStack{
                        ScrollView{
                            Text("Dimanche")
                                .font(.title3)
                                .padding(20)
                            ForEach(0..<creneauxDimanche.count, id: \.self) {index in
                                HStack{
                                    Text(self.creneauxDimanche[index])
                                        .padding(10)
                                    Divider()
                                    Spacer()
                                    NavigationLink(destination: InscriptionPostesDimancheView(creneau: self.creneauxDimanche[index])){
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
                        //
                        //NavigationLink(destination: ProfileView()){
                        //    Image(systemName: "person")
                        //}
                        //
                        //Spacer()
                        //
                        //NavigationLink(destination: PlanningPersonnelView()){
                        //    Image(systemName: "calendar")
                        //}
                        //
                        //Spacer()
                        //
                        //NavigationLink(destination: InscriptionSamediView()){
                        //    Image(systemName: "list.bullet.clipboard")
                        //}
                        //
                        //Spacer()
                        //
                        //NavigationLink(destination: ProfileView()){
                        //    Image(systemName: "hourglass")
                        //}
                        //Spacer()
                        
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
