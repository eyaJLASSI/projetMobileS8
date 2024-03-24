//
//  PlanningCandidatureViewModel.swift
//  
//
//  Created by etud on 24/03/2024.
//

import Foundation

 class PlanningCandidatureViewModel : ObservableObject, Hashable, Identifiable {
 
 static func == (lhs: PlanningCandidatureViewModel, rhs: PlanningCandidatureViewModel) -> Bool {
 return
 lhs.candidatures == rhs.candidatures &&
 lhs.postes == rhs.postes &&
 lhs.espaces == rhs.espaces &&
 lhs.creneaux == rhs.creneaux
 //lhs.nombrePlaceTotal == rhs.nombrePlaceTotal
 }
 
 
 var observers : [ViewModelObserver] = []
 
 @Published var creneaux : [CreneauDTO]{
 didSet{
 for o in self.observers{
 o.viewModelUpdated()
 }
 }
 }
 
 @Published var espaces : [EspaceDTO]{
 didSet{
 for o in self.observers{
 o.viewModelUpdated()
 }
 }
 }
 
 @Published var postes : [PosteDTO]{
 didSet{
 for o in self.observers{
 o.viewModelUpdated()
 }
 }
 }
 
 @Published var candidatures : [CandidatureDTO]{
 didSet{
 for o in self.observers{
 o.viewModelUpdated()
 }
 }
 }
  
 init(
 creneaux         : [CreneauDTO],
 espaces          : [EspaceDTO],
 candidatures     : [CandidatureDTO],
 postes           : [PosteDTO]
 //nombrePlaceTotal : [Two<Int, Int>: Int]
 ) {
 self.candidatures     = candidatures
 self.creneaux         = creneaux
 self.espaces          = espaces
 self.postes           = postes
 //self.nombrePlaceTotal = nombrePlaceTotal
 }
 
 init(
 plannning         : PlanningCandidatureDTO
 ) {
 self.candidatures     = plannning.candidatures
 self.creneaux         = plannning.creneaux
 self.espaces          = plannning.espaces
 self.postes           = plannning.postes
 //self.nombrePlaceTotal = plannning.nombrePlaceTotal
 }
 
 init(){
 //self.nombrePlaceTotal = [:]
 self.candidatures = []
 self.creneaux = []
 self.espaces = []
 self.postes = []
 }
 
 func hash(into hasher: inout Hasher){
 hasher.combine(self.candidatures)
 hasher.combine(self.postes)
 hasher.combine(self.creneaux)
 hasher.combine(self.espaces)
 //hasher.combine(self.nombrePlaceTotal)
 }
 
 
 func register(obs: ViewModelObserver){
 self.observers.append(obs)
 }
 
 @Published var state : PlanningState = .ready
 {
 didSet
 {
 switch state
 {
 case .ready:
 debugPrint("view model : ready")
 case .loaded :
 debugPrint("view model : espace found")
 }
 }
 }
 
 }
 
