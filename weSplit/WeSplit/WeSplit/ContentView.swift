//
//  ContentView.swift
//  WeSplit
//
//  Created by Mariana Montoya on 11/18/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @State private var zeroTip = false
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages: [Int] = Array(0...100)

    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValuer = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValuer
        let amountPerPerson = grandTotal / peopleCount
        // calculate the total per person here
        return amountPerPerson
    }
    
    var grandTotal: Double{
        let tipSelection = Double(tipPercentage)
        
        let tipValuer = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValuer
        return grandTotal
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                                .foregroundStyle($0 == 0 ? .red : .black)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .onChange(of: tipPercentage){
                        newValue in zeroTip = (newValue == 0)
                    }
                    
                }
                
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total Amount for the Check"){
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(zeroTip ? .red : .black)
                        
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
            
        }
    }
}


#Preview {
    ContentView()
}
