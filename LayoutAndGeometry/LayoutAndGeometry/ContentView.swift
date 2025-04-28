//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Mariana Montoya on 4/28/25.
//

import SwiftUI
extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
            }
    }
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
//       Text("Hello, world!")
        // They yield different results in the way they are placed
//            .padding(20)
//            .background(.red)
        
//        Color.red
        
//        Text("Live long and prosper")
//            .frame(width: 300, height: 300, alignment: .topLeading)
        
//        HStack(alignment: .lastTextBaseline) {
//            Text("Live")
//                .font(.caption)
//            
//            Text("Long")
//            
//            Text("and")
//                .font(.title)
//            
//            Text("prosper")
//                .font(.largeTitle)
//        }
        
        VStack(alignment: .leading){
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                        Double(position) * -10
                    }
            }
        }
        
        HStack(alignment: .midAccountAndName){
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                
            }
            
            VStack {
                Text("Full name: ")
                Text("Paul Hudson")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
        
        Text("Hello, world!")
            .offset(x: 100, y: 100)
            .background(.red)
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
        
    }
}

#Preview {
    ContentView()
}
