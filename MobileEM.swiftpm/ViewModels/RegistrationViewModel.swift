//
//  File.swift
//
//
//  Created by etud on 18/03/2024.
//

import Foundation

class RegistrationViewModel : ObservableObject, Hashable, Identifiable {
    
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
    
    @Published var association : String{
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
    
    
    @Published var registratonFailedMessage : String = ""
    
    init(registrationDTO : RegistrationDTO){
        self.pseudo = registrationDTO.pseudo
        self.nom = registrationDTO.nom
        self.prenom = registrationDTO.prenom
        self.password = registrationDTO.password
        self.email = registrationDTO.email
        self.numTel = registrationDTO.numTel
        self.association = registrationDTO.association
    }
    
    init(){
        self.pseudo=""
        self.nom=""
        self.prenom=""
        self.password=""
        self.email=""
        self.numTel=""
        self.association""
    }
    
    func initialiser(registrationDTO: RegistrationDTO)
    {
        self.pseudo = registrationDTO.pseudo
        self.nom = registrationDTO.nom
        self.prenom = registrationDTO.prenom
        self.password = registrationDTO.password
        self.email = registrationDTO.email
        self.numTel = registrationDTO.numTel
        self.association = registrationDTO.association
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
            case .registered(let registrationDto)
                debugPrint("Registered user \(registrationDto.pseudo)")
            case.registrationFailed(let error)
                debugPrint("Failed to register used. Error : \(error)")
            }
        }
    }
    
}
