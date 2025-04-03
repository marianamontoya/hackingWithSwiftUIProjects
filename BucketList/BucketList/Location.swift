//
//  Location.swift
//  BucketList
//
//  Created by Mariana Montoya on 3/31/25.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
#if DEBUG
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Queen is here love", latitude: 51.501, longitude: -0.141)
#endif
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
