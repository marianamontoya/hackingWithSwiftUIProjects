//
//  ContentView.swift
//  HotProspects
//
//  Created by Mariana Montoya on 4/15/25.
//

import SamplePackage
import SwiftUI
import UserNotifications
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
    @State private var backgroundColor = Color.red
    
    let possibleNumbers = 1...60
    
    var results: String {
        // more code to come
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
        Image(.example)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .background(.black)
        
        Text("Change Color")
            .padding()
            .contextMenu{
                Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                    backgroundColor = .red
                }
                Button("Green") {
                    backgroundColor = .green
                    
                }
            }
        
        Text("Rosalia")
            .swipeActions{
                Button("Delete", systemImage: "minus.circle", role: .destructive){
                    print("Delete")
                }
            }
            .swipeActions(edge: .leading) {
                Button("Pin", systemImage: "pin") {
                    print("Pinning")
                }
                .tint(.orange)
            }
        
        VStack {
            Button("Request Premission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                            print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                    
                }
            }
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It's time to give it some milk"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
                
            }
        }
        
        Text(results)
        
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
