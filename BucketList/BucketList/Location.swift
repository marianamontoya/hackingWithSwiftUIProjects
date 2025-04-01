//
//  Location.swift
//  BucketList
//
//  Created by Mariana Montoya on 3/31/25.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
