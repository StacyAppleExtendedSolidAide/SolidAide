//
//  GPSCoordonateStruct.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//
import Foundation
import MapKit
//import CoreLocation

//struct GPSCoordinateStruct: Codable {
//    var latitude: Double?
//    var longitude: Double?
//    
//    init(coordinate: CLLocationCoordinate2D?) {
//        self.latitude = coordinate?.latitude ?? 0.0
//        self.longitude = coordinate?.longitude ?? 0.0
//    }
//}
struct GPSCoordinateStruct: Codable {
    var latitude: Double?
    var longitude: Double?
    var altitude: Double?          // ← ajoute cette ligne si tu veux garder l'altitude

    // Constructeur complet
    init(latitude: Double?, longitude: Double?, altitude: Double? = nil) {
        self.latitude  = latitude
        self.longitude = longitude
        self.altitude  = altitude
    }

    // Constructeur depuis CLLocationCoordinate2D (utile ailleurs)
    init(coordinate: CLLocationCoordinate2D?) {
        self.latitude  = coordinate?.latitude
        self.longitude = coordinate?.longitude
        self.altitude  = nil
    }
}
