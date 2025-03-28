//
//  ContentView.swift
//  BetterRest
//
//  Created by Mariana Montoya on 12/16/24.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var recommendedBedtime = "No recommendation yet"
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("When do you want to wake up?")){
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                }
                
                Section(header: Text("Desired amount of sleep")){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    
                }
                
                Section(header: Text("Daily coffe intake")){
                    //                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    
                    Picker("Coffee Amount", selection: $coffeeAmount){
                        ForEach(1...20, id: \.self) { amount in
                            Text("\(amount) \(amount == 1 ? "cup" : "cups")")
                                .tag(amount)
                        }
                    }
                    .pickerStyle(.wheel)
                    .onChange(of: coffeeAmount) {_ in calculateBedTime() }
                }
                
                Section(header: Text("Your recommended bedtime")){
                    Text(recommendedBedtime)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                        .multilineTextAlignment(.center)
                }
                

            }
            .navigationTitle("BetterRest")
            .onAppear(perform: calculateBedTime)
        }
    }
    
    func calculateBedTime(){
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute),
                estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            recommendedBedtime = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            recommendedBedtime = "Error calculating bedtime"
        }
        
    }
    
}


#Preview {
    ContentView()
}

