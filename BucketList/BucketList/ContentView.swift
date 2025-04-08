//
//  ContentView.swift
//  BucketList
//
//  Created by Mariana Montoya on 3/29/25.
//
//import MapKit
//import SwiftUI
//
//struct Location: Identifiable {
//    let id = UUID()
//    var name: String
//    var coordinate: CLLocationCoordinate2D
//}
//
//struct ContentView: View {
////    @State private var position = MapCameraPosition.region(MKCoordinateRegion(
////        center: CLLocationCoordinate2D(latitude: -23.041, longitude: -43.505), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
////    )
//    
//    let locations = [
//        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//        
//    ]
//    var body: some View {
//        VStack {
//            MapReader { proxy in
//                Map()
//                    .onTapGesture { position in
//                        if let coordinate = proxy.convert(position, from: .local) {
//                            print(coordinate)
//                    }
//            }
//            }
//    
//            Button("Paris") {
//                position = MapCameraPosition.region(MKCoordinateRegion(
//                    center: CLLocationCoordinate2D(latitude: 48.8655, longitude: 2.3522), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
//                )
//            }
//            Button("Tokyo") {
//                position = MapCameraPosition.region(MKCoordinateRegion(
//                    center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
//                )
//            }
            
//        }
//    }
//}
//
//
//
//
//#Preview {
//    ContentView()
//}

//
//struct User: Comparable, Identifiable {
//    let id = UUID()
//    var firstName: String
//    var lastName: String
//    
//    static func <(lhs: User, rhs: User) -> Bool {
//        lhs.lastName < rhs.lastName
//    }
//}
//
//struct LoadingView: View {
//    var body: some View {
//        Text("Loading..")
//    }
//}
//
//struct SuccessView: View {
//    var body: some View {
//        Text("Success!")
//    }
//}
//
//struct FailedView: View {
//    var body: some View {
//        Text("Failed.")
//    }
//}
//
//struct ContentView: View {
//    enum LoadingState {
//        case loading, success, failed
//    }
//    @State private var loadingState = LoadingState.loading
//    
//        
//    var body: some View {
//        switch loadingState {
//        case .loading:
//            LoadingView()
//        case .success:
//            SuccessView(
//        case .failed:
//            FailedView()
//        }
//    }
//}


//        VStack {
//            List(users) { user in
//                Text("\(user.firstName),  \(user.lastName)")
//            }
//        }
//        Button("Read and Write") {
//            let data = Data("Text Message".utf8)
//            let url = URL.documentsDirectory.appending(path: "message.txt")
//
//            do {
//                try data.write(to: url, options: [.atomic, .completeFileProtection])
//                let input = try String(contentsOf: url)
//                print(input)
//            } catch {
//                print(error.localizedDescription)
//            }

//import LocalAuthentication
//import SwiftUI

//struct ContentView: View {
//    @State private var isUnlocked = false
//    var body: some View {
//        VStack {
//            if isUnlocked {
//                Text("Unlocked")
//            } else {
//                Text("Locked")
//            }
//        }
//        .onAppear(perform: authenticate)
//    }
//    
//    func authenticate() {
//        let context = LAContext()
//        var error: NSError?
//        
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let reason = "We need to unlock your data."
//            
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticateError in
//                if success {
//                    isUnlocked = true
//                } else {
//                    
//                }
//                
//            }
//        } else {
//            
//        }
//    }
//}
import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -23.008842745980573, longitude: -43.36903107689417), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    @State private var viewModel = ViewModel()
    @State private var mapStyle: MapStyle = .standard

    var body: some View {
        if viewModel.isUnlocked{
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .contentShape(Rectangle()) // Defines the tappable area
                                .onTapGesture(count: 2) {
                                    print("Double tapped!")
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(mapStyle)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                        
                    }
                }
            }
        } else {
            Button("Unlocked Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
        HStack{
            Button("Standard Map View"){
                mapStyle = .standard
            }
            .padding()
            Button("Hybrid Map View"){
                mapStyle = .hybrid
            }
            .padding()
            
        }
    }
}

#Preview{
    ContentView()
}

