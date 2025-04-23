//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Mariana Montoya on 4/15/25.
//
import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
