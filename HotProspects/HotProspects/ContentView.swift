//
//  ContentView.swift
//  HotProspects
//
//  Created by Mariana Montoya on 4/15/25.
//

import SwiftUI

//struct ContentView: View {
//    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
//    @State private var selection = Set<String>()
//    
//    var body: some View {
//        List(users, id: \.self, selection: $selection) { user in
//            Text(user)
//        }
//        if selection.isEmpty == false{
//            Text("You selected: \(selection.formatted())")
//        }
//        
//        EditButton()
//    }
//}

struct ContentView: View {
    @State private var selectedTab = "One"
    var body: some View {
        TabView(selection: $selectedTab){
            Button("Show Tab 2"){
                selectedTab = "Two"
            }
            .tabItem{
                Label("One", systemImage: "star")
            }
            .tag("One")
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

#Preview {
    ContentView()
}
