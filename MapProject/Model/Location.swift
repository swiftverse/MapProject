//
//  Location.swift
//  MapProject
//
//  Created by Amit Shrivastava on 10/01/22.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    //in case of instance issues use cpmputed properties
    var coordinate:  CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Indian parliament", description: "Where India parliament is located", latitude: 28.6172, longitude: 77.2082)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
