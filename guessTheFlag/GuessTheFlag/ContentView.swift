//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mariana Montoya
//

import SwiftUI


struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var showingFinalScore = false
    
    @State private var userScore = 0
    @State private var questionCount = 0
    
    @State private var rotationAngle = 0.0
    @State private var selectedAnswer: Int? = nil
    @State private var fadeOut = false
    @State private var exitAnimationTriggered = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green:0.2, blue:0.45), location: 0.3),
                .init(color: .red, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .modifier(Title())
                    .foregroundStyle(.white)
                VStack (spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                            if number == correctAnswer {
                                withAnimation(.easeInOut(duration: 0.5)){
                                    rotationAngle += 360
                                    fadeOut = true
                                    exitAnimationTriggered = true
                                }
                            }
                            selectedAnswer = number
                            
                        } label :{
                            FlagImage(country: countries[number])
                        }
                        .rotation3DEffect(.degrees(number == correctAnswer ? rotationAngle : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(changeOpacity(number))
                        .offset(getOffset(number))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
            .alert(scoreTitle, isPresented: $showingScore){
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(userScore)")
            }
            .alert("Game Over", isPresented: $showingFinalScore) {
                Button("Restart", action: restartGame)
            } message: {
                Text("Your final score is \(userScore) out of 8")
            }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong YOU DUMMY that's the flag of \(countries[number])"
            userScore -= 1
        }
        questionCount += 1
        if questionCount < 8 {
            showingScore = true
        } else {
            showingFinalScore = true
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        rotationAngle = 0
        fadeOut = false
        selectedAnswer = nil
        exitAnimationTriggered = false
    }
    
    func restartGame() {
        userScore = 0
        questionCount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func changeOpacity(_ number: Int) -> Double{
        if exitAnimationTriggered {
            return number == correctAnswer ? 1.0 : 0.25 // Fade out incorrect buttons
        }
        return 1.0 // Default opacity for all buttons
    }
    
    func getOffset(_ number: Int) ->CGSize{
        guard exitAnimationTriggered, let selected = selectedAnswer else {
            return .zero // Default position
        }
        if number == selected {
            return .zero // Selected button stays in place
        } else {
            return number % 2 == 0
                ? CGSize(width: -500, height: 0) // Move left for even-indexed buttons
                : CGSize(width: 500, height: 0) // Move right for odd-indexed buttons
        }
    }

    
}

struct FlagImage : View{
    var country: String
    
    var body: some View {
        Image(country)
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 100)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct Title: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    ContentView()
}
