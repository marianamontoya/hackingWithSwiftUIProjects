//
//  Card.swift
//  Flashzilla
//
//  Created by Mariana Montoya on 4/26/25.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor who?", answer: "Jodie Whittaker")
    
    
}
