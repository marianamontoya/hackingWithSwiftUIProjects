//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Mariana Montoya on 4/9/25.
//

import SwiftUI

//struct ContentView: View {
//    let pictures = [
//        "ales-krivec-15949@2x", "galina-n-189483@2x", "kevin-horstmann-141705@2x", "nicolas-tissot-335096@2x"
//    ]
//    
//    let labels = [
//        "Tulips",
//        "Frozen tree buds",
//        "Sunflowers",
//        "Fireworks"
//    ]
//    
//    @State private var selectedPicture = Int.random(in: 0...3)
//    
//    
//    var body: some View {
//        Button {
//            selectedPicture = Int.random(in: 0...3)
//        } label: {
//            Image(pictures[selectedPicture])
//                .resizable()
//                .scaledToFit()
//                .onTapGesture {
//                    selectedPicture = Int.random(in: 0...3)
//                }
//        }
//        .accessibilityLabel(labels[selectedPicture])
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Your score is")
//            
//            Text("1000")
//                .font(.title)
//        }
//        .accessibilityElement(children: .ignore)
//        .accessibilityLabel("Your score is 1000")
//        
//    }
//}

struct ContentView: View {
    @State private var value = 10
    var body: some View {
        VStack {
            Text("Value: \(value)")
            
            Button("Increment") {
                value += 1
                print("Button tapped")
            }
            .accessibilityInputLabels(["Button","Button tapped"])
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction{ direction in
            switch direction{
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
    }
}

#Preview {
    ContentView()
}
