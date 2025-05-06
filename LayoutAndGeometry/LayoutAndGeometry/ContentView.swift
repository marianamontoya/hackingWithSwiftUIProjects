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
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
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
//        
//        VStack(alignment: .leading){
//            ForEach(0..<10) { position in
//                Text("Number \(position)")
//                    .alignmentGuide(.leading) { _ in
//                        Double(position) * -10
//                    }
//            }
//        }
//        
//        HStack(alignment: .midAccountAndName){
//            VStack {
//                Text("@twostraws")
//                    .alignmentGuide(.midAccountAndName) { d in
//                        d[VerticalAlignment.center]
//                    }
//                
//            }
//            
//            VStack {
//                Text("Full name: ")
//                Text("Paul Hudson")
//                    .alignmentGuide(.midAccountAndName) { d in
//                        d[VerticalAlignment.center]
//                    }
//                    .font(.largeTitle)
//            }
//        }
//        
//        Text("Hello, world!")
//            .offset(x: 100, y: 100)
//            .background(.red)
//        .background(.red)
//        .frame(width: 400, height: 400)
//        .background(.blue)
//        HStack {
//            Text("Important")
//                .frame(width: 200)
//                .background(.blue)
//            
//            GeometryReader { proxy in
//                Image(.background)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: proxy.size.width * 0.8)
//                        .frame(width: proxy.size.width, height: proxy.size.height)
//            }
//            
//            GeometryReader { proxy in
//                Text("Hello, world!")
//                    .frame(width: proxy.size.width * 0.9)
//                    .background(.red)
//                
//            }
//            
//        }
//        
        ScrollView {
            GeometryReader { fullView in
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5,
                                axis: (x: 0, y: 1, z: 0)
                            )
                        
                    }
                    
                }
            }
        }
        
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(1..<20) { number in
                          Text("Number \(number)")
                              .font(.largeTitle)
                              .padding()
                              .background(.red)
                              .frame(width: 200, height: 200)
                              .visualEffect{ content, proxy in
                                  content
                                      .rotation3DEffect(
                                        .degrees(-proxy.frame(in: .global).minX / 8),
                                        axis: (x: 0, y: 1, z: 0)
                                      )
                              }
                    
                  }
            }
                .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)

    }
}

#Preview {
    ContentView()
}
