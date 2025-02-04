//
//  ContentView.swift
//  WordScramble
//
//  Created by Mariana Montoya on 12/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Score: \(score)")
                    .font(.headline)
                    .padding()
                List{
                    Section{
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    Section{
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError){
                    Button("OK") {}
                } message: {
                    Text(errorMessage)
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button("Restart!!"){
                            startGame()
                        }
                    }
                }
            }
        }
    }
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)' !")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard tooShort(word: answer) else {
            wordError(title: "Word too short", message: "Answer must be greater than 2 letters!")
            return
        }
        
        guard sameWord(word: answer) else {
            wordError(title: "Same word", message: "You must come up with new words!")
            return
        }
        
        
        withAnimation{
            usedWords.insert(answer, at:0)
            updateScore(for: answer)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func tooShort(word: String) -> Bool {
        if word.count < 3{
            return false
        }
        return true
    }
    
    func sameWord(word: String) -> Bool {
        if word == rootWord {
            return false
        }
        return true
    }
    
    func updateScore(for word: String) {
        score += word.count + usedWords.count
    }

}

#Preview {
    ContentView()
}
