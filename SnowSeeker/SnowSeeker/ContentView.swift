//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Mariana Montoya on 5/5/25.
//

import SwiftUI

struct User: Identifiable {
    var id = "Rosalia"
}

@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HighScoreView: View {
    var player: Player
    
    var body: some View {
        Text("Your high score: \(player.highScore)")
    }
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}
struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    @State private var layoutVertically = false
    @State private var searchText = ""
    @Environment(Player.self) var player
    let allNames = ["Subh", "Vina", "Melvin", "Stefani"]
    var filteredNames: [String] {
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { name in
                name.localizedStandardContains(searchText)
                
            }
        }
    }
    
    var body: some View {
        @Bindable var player = Player()
//        NavigationSplitView(columnVisibility: .constant(.all)) {
//            NavigationLink("Primary") {
//                Text("New View")
//            }
//        } detail: {
//            Text("Content")
//                .toolbar(.hidden, for: .navigationBar)
//        }
//        .navigationSplitViewStyle(.balanced)
        
        Button("Tap Me") {
            selectedUser = User()
            isShowingUser = true
        }
        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) {
            user in
            Button(user.id) { }
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
                .presentationDetents([.medium, .large])
        }
        
        Button {
            layoutVertically.toggle()
        } label : {
            if horizontalSizeClass == .compact {
                VStack {
                    UserView()
                }
            }
            else {
                HStack {
                    UserView()
                }
            }
            }
        NavigationStack {
            List(filteredNames, id: \.self) { name in
                Text(name)
                
            }
                .searchable(text: $searchText, prompt: "Look for something")
                .navigationTitle("Searching")
        }
        
        VStack {
            Text("Welcome!")
            HighScoreView()
        }
        .environment(player)
        
        }
}

#Preview {
    ContentView()
}
