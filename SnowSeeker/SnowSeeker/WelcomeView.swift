//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Mariana Montoya on 5/7/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Welcome to SnowSeeeker")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu: swipe from the edge to show it.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
