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

//struct ContentView: View {
//    @State private var selectedTab = "One"
//    var body: some View {
//        TabView(selection: $selectedTab){
//            Button("Show Tab 2"){
//                selectedTab = "Two"
//            }
//            .tabItem{
//                Label("One", systemImage: "star")
//            }
//            .tag("One")
//            Text("Tab 2")
//                .tabItem {
//                    Label("Two", systemImage: "circle")
//                }
//                .tag("Two")
//        }
//    }
//}

struct ContentView: View {
    @State private var output = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
        Image(.example)
            .resizable()
            .scaledToFit()
            .background(.black)
        
    }
    
    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        let result = await fetchTask.result
        
        switch result {
            case .success(let str):
                output = str
            case .failure(let error):
                output = "Error: \(error.localizedDescription)"
            
        }
    }
}

#Preview {
    ContentView()
}
