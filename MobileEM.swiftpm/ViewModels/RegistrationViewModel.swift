//
//  RegistrationViewModel.swift
//
//
//  Created by etud on 18/03/2024.
//

import Foundation

class RegistrationViewModel : ObservableObject, Hashable, Identifiable {
    static func == (lhs: RegistrationViewModel, rhs: RegistrationViewModel) -> Bool {
        return lhs.pseudo == rhs.pseudo
    }
    
    
    var observers : [ViewModelObserver] = []
    
    @Published var pseudo : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
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
    
    @Published var vegetarian : Bool{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    
    @Published var registratonFailedMessage : String = ""
    
    init(registrationDTO : RegistrationDTO){
        self.pseudo = registrationDTO.pseudo
        self.nom = registrationDTO.nom
        self.prenom = registrationDTO.prenom
        self.password = registrationDTO.password
        self.email = registrationDTO.email
        self.numTel = registrationDTO.numTel
        self.chercheLogement = registrationDTO.chercheLogement
        self.taille = registrationDTO.taille
        self.vegetarian = registrationDTO.vegetarian
    }
    
    init(){
        self.pseudo=""
        self.nom=""
        self.prenom=""
        self.password=""
        self.email=""
        self.numTel=""
        self.taille=""
        self.chercheLogement=false
        self.vegetarian=false
    }
    
    func initialiser(registrationDTO: RegistrationDTO)
    {
        self.pseudo = registrationDTO.pseudo
        self.nom = registrationDTO.nom
        self.prenom = registrationDTO.prenom
        self.password = registrationDTO.password
        self.email = registrationDTO.email
        self.numTel = registrationDTO.numTel
        self.chercheLogement = registrationDTO.chercheLogement
        self.taille = registrationDTO.taille
        self.vegetarian = registrationDTO.vegetarian
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.pseudo)
    }
    
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
    @Published var state : RegistrationState = .ready
    {
        didSet
        {
            switch state
            {
                case .ready:
                    debugPrint("view model : ready")
            case .registered(let registrationDto):
                debugPrint("Registered user \(registrationDto.pseudo)")
            case.registrationFailed(let error):
                debugPrint("Failed to register used. Error : \(error)")
            }
        }
    }
    
}
