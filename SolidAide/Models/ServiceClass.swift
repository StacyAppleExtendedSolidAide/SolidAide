////
////  ServiceClass.swift
////  SolidAide
////
////  Created by apprenant78 on 27/10/2025.
////
//
//import Foundation
//import SwiftData
//
//@Model
//class ServiceClass: Identifiable {
//    var id = UUID()
//    var profilId: ProfileClass
//    var profilIdHelper: ProfileClass? = nil
//    @Attribute private var skillRawValue: String
//    var skill: SkillsEnum {
//        get {
//            guard let skill = SkillsEnum(rawValue: skillRawValue) else {
//                fatalError("Erreur fatale : skillsRawValue corrompue")
//            }
//            return skill
//        }
//        
//        set { skillRawValue = newValue.rawValue }
//        
//    }
//    var serviceDescription: String
//    var city: String
//    var isFree: Bool = false
//    var timeSpent: Int
//    var startDate: Date
//    @Attribute private var serviceRepeatRawValue: String? = nil
//    var serviceRepeat: ServiceRepeatEnum? {
//        get {
//            guard let rawValue = serviceRepeatRawValue else { return nil }
//            return ServiceRepeatEnum(rawValue: rawValue)
//        }
//        
//        set {
//            serviceRepeatRawValue = newValue?.rawValue
//        }
//        
//    }
//    @Attribute private var requestStatusRawValue: String
//    var requestStatus: RequestStatusEnum {
//        get {
//            return RequestStatusEnum(rawValue: requestStatusRawValue) ?? .awaitingAcceptance
//        }
//        
//        set {
//            requestStatusRawValue = newValue.rawValue
//        }
//        
//    }
//    var isEvaluationCompleted: Bool = false
//    var isFulfilled: Bool = false
//    var serviceComment: String? = nil
//    
//    init(
//        profilId: ProfileClass,
//        profilIdHelper: ProfileClass? = nil,
//        skill: SkillsEnum,
//        serviceDescription: String,
//        city: String,
//        isFree: Bool,
//        timeSpent: Int,
//        startDate: Date,
//        requestStatusRawValue: String? = nil,
//        serviceRepeat: ServiceRepeatEnum? = nil,
//        requestStatus: RequestStatusEnum = .awaitingAcceptance,
//        isEvaluationCompleted: Bool = false,
//        isFulfilled: Bool = false,
//        serviceComment: String? = nil
//    ) {
//        self.profilId = profilId
//        self.profilIdHelper = profilIdHelper
//        self.skillRawValue = skill.rawValue
//        self.serviceDescription = serviceDescription
//        self.city = city
//        self.isFree = isFree
//        self.timeSpent = timeSpent
//        self.startDate = startDate
//        self.serviceRepeatRawValue = serviceRepeat?.rawValue
//        self.requestStatusRawValue = requestStatus.rawValue
//        self.isEvaluationCompleted = isEvaluationCompleted
//        self.isFulfilled = isFulfilled
//        self.serviceComment = serviceComment
//    }
//}
//
//  ServiceClass.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import Foundation
import SwiftData

@Model
class ServiceClass: Identifiable {
    var id = UUID()
    var profilId: ProfileClass
    var profilIdHelper: ProfileClass? = nil
    
    // ── Skill ───────────────────────────────────────
    @Attribute private var skillRawValue: String
    var skill: SkillsEnum {
        get {
            guard let skill = SkillsEnum(rawValue: skillRawValue) else {
                fatalError("Erreur fatale : skillRawValue corrompue")
            }
            return skill
        }
        set { skillRawValue = newValue.rawValue }
    }
    
    // ── Description & ville ───────────────────────────
    var serviceDescription: String
    var city: String
    
    // ── Position géographique (nouveau) ───────────────
    @Attribute private var positionRaw: GPSCoordinateStruct?   // stockée dans la DB
    var position: GPSCoordinateStruct? {
        get { positionRaw }
        set { positionRaw = newValue }
    }
    
    // ── Autres champs ─────────────────────────────────
    var isFree: Bool = false
    var timeSpent: Int
    var startDate: Date
    
    @Attribute private var serviceRepeatRawValue: String? = nil
    var serviceRepeat: ServiceRepeatEnum? {
        get {
            guard let raw = serviceRepeatRawValue else { return nil }
            return ServiceRepeatEnum(rawValue: raw)
        }
        set { serviceRepeatRawValue = newValue?.rawValue }
    }
    
    @Attribute private var requestStatusRawValue: String
    var requestStatus: RequestStatusEnum {
        get { RequestStatusEnum(rawValue: requestStatusRawValue) ?? .awaitingAcceptance }
        set { requestStatusRawValue = newValue.rawValue }
    }
    
    var isEvaluationCompleted: Bool = false
    var isFulfilled: Bool = false
    var serviceComment: String? = nil
    
    // ── Initialiseurs ─────────────────────────────────
    /// Initialise un service.
    ///
    /// - Parameters:
    ///   - profilId: le profil qui propose le service
    ///   - profilIdHelper: (optionnel) le profil qui aide à réaliser le service
    ///   - skill: compétence associée
    ///   - serviceDescription: texte descriptif
    ///   - city: ville où le service est proposé
    ///   - position: coordonnées GPS (optionnel)
    ///   - isFree: le service est‑il gratuit ?
    ///   - timeSpent: durée prévue en heures
    ///   - startDate: date de début prévue
    ///   - serviceRepeat: périodicité éventuelle
    ///   - requestStatus: état de la demande
    ///   - isEvaluationCompleted: l’évaluation a‑t‑elle été faite ?
    ///   - isFulfilled: le service a‑t‑il été réalisé ?
    ///   - serviceComment: commentaire libre (optionnel)
    init(
        profilId: ProfileClass,
        profilIdHelper: ProfileClass? = nil,
        skill: SkillsEnum,
        serviceDescription: String,
        city: String,
        position: GPSCoordinateStruct? = nil,          // ← nouveau paramètre
        isFree: Bool,
        timeSpent: Int,
        startDate: Date,
        serviceRepeat: ServiceRepeatEnum? = nil,
        requestStatus: RequestStatusEnum = .awaitingAcceptance,
        isEvaluationCompleted: Bool = false,
        isFulfilled: Bool = false,
        serviceComment: String? = nil
    ) {
        // 1️⃣ Initialise les propriétés stockées (obligatoire avant tout accès à `self`)
        self.profilId = profilId
        self.profilIdHelper = profilIdHelper
        self.skillRawValue = skill.rawValue
        self.serviceDescription = serviceDescription
        self.city = city
        self.isFree = isFree
        self.timeSpent = timeSpent
        self.startDate = startDate
        self.serviceRepeatRawValue = serviceRepeat?.rawValue
        self.requestStatusRawValue = requestStatus.rawValue
        self.isEvaluationCompleted = isEvaluationCompleted
        self.isFulfilled = isFulfilled
        self.serviceComment = serviceComment
        
        // 2️⃣ Maintenant que toutes les propriétés sont initialisées,
        //    on peut assigner la position.
        self.positionRaw = position          // ou `self.position = position`
    }
}
