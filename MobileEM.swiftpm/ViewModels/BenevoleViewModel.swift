//
//  File.swift
//  
//
//  Created by etud on 18/03/2024.
//

import Foundation

class BenevoleViewModel : ObservableObject, Hashable, Identifiable {
    static func == (lhs: BenevoleViewModel, rhs: BenevoleViewModel) -> Bool {
        return lhs.pseudo == rhs.pseudo
    }
    
    
    var observers : [ViewModelObserver] = []
    
    @Published var pseudo : String
    
    @Published var nom : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }

        @Published var prenom : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }
    
    @Published var email : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }
        
        @Published var password : String{
            didSet{
                for o in self.observers{
                    o.viewModelUpdated()
                }
            }
        }
    
    @Published var numTel : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var chercheLogement : Bool{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var taille : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var vegetarien : Bool{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    
    @Published var authFailedMessage : String = ""
    
    init(BenevoleDTO : BenevoleDTO){
        self.pseudo = BenevoleDTO.pseudo
        self.nom = BenevoleDTO.nom
        self.prenom = BenevoleDTO.prenom
        self.password = BenevoleDTO.password
        self.email = BenevoleDTO.email
        self.numTel = BenevoleDTO.numTel
        self.chercheLogement = BenevoleDTO.chercheLogement
        self.taille = BenevoleDTO.taille
        self.vegetarien = BenevoleDTO.vegetarian
    }
    
    init(){
        self.pseudo=""
        self.nom=""
        self.prenom=""
        self.password=""
        self.email=""
        self.numTel=""
        self.chercheLogement=false
        self.taille=""
        self.vegetarien=false
    }
    
    func initialiser(benevoleDTO: BenevoleDTO)
    {
        self.pseudo = benevoleDTO.pseudo
        self.nom = benevoleDTO.nom
        self.prenom = benevoleDTO.prenom
        self.password = benevoleDTO.password
        self.email = benevoleDTO.email
        self.numTel = benevoleDTO.numTel
        self.chercheLogement = benevoleDTO.chercheLogement
        self.taille = benevoleDTO.taille
        self.vegetarien = benevoleDTO.vegetarian
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.pseudo)
    }
    
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
    @Published var state : BenevoleState = .ready
    {
        didSet
        {
            switch state
            {
                case .ready:
                    debugPrint("view model : ready")
                case .loggedIn(let benevoleDTO):
                    debugPrint("view model : loggedin")
                    initialiser(benevoleDTO: benevoleDTO)
                case .authFailed(let error):
                    debugPrint(("view model : authentification failed"))
                    self.authFailedMessage = "\(error)"
            }
        }
    }
    
}
