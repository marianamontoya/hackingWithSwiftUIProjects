//
//  ContentView.swift
//  unitConversion
//
//  Created by Mariana Montoya on 11/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Feet"
    @State private var inputValue = 0.0
    
    let units = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    
    var conversionResult: Double {
        let inputInMeters = convertToMeters(value: inputValue, unit: inputUnit)
        return convertFromMeters(value: inputInMeters, unit: outputUnit)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Input Value")) {
                    TextField("Enter value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Select Input Unit")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select Output Unit")) {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Conversion Result")) {
                    Text("\(conversionResult, specifier: "%.2f") \(outputUnit)")
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
    
    // Convert input value to meters
    func convertToMeters(value: Double, unit: String) -> Double {
        switch unit {
        case "Meters": return value
        case "Kilometers": return value * 1000
        case "Feet": return value / 3.281
        case "Yards": return value / 1.094
        case "Miles": return value * 1609.34
        default: return value
        }
    }
    
    // Convert meters to the output unit
    func convertFromMeters(value: Double, unit: String) -> Double {
        switch unit {
        case "Meters": return value
        case "Kilometers": return value / 1000
        case "Feet": return value * 3.281
        case "Yards": return value * 1.094
        case "Miles": return value / 1609.34
        default: return value
        }
    }
}

#Preview {
    ContentView()
}
