//
//  AddContractView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 09/07/2024.
//

import SwiftUI
import SwiftData

struct AddContractView: View {
    @State private var selectedResort: Resort? = nil
    @State private var points = "200"
    @State private var selectedUseYear: UseYear? = nil
    
    @Query var resorts: [Resort] = []
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var availableUseYears: [UseYear] = [.February, .March, .April, .June, .August, .September, .October, .December]
    
    func getExpireYear(resort: Resort) -> Int {
        var expireYear = 2070
        if resort.resortName == "Disney's Polynesian Villas & Bungalows" {
            expireYear = 2066
        } else if resort.resortName == "Disney's Riviera Resort" {
            expireYear = 2070
        }
        return expireYear
    }
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Home Resort")
                    
                    Spacer()
                    
                    Menu {
                        Picker(selection: $selectedResort, label: EmptyView()) {
                            Text("Select a Resort").tag(nil as Resort?)
                            ForEach(resorts.sorted()) { resort in
                                Text(resort.resortName)
                                    .lineLimit(1)
                                    .tag(resort as Resort?)
                            }
                        }
                    } label: {
                        Text(selectedResort?.resortName ?? "Select a Resort")
                            .lineLimit(1)
                    }
                }
                
                HStack {
                    Text("Points")
                    
                    Spacer()
                    
                    TextField("Points", text: $points)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
                
                HStack {
                    Text("Use Year")
                    
                    Spacer()
                    
                    Menu {
                        Picker(selection: $selectedUseYear, label: EmptyView()) {
                            Text("Select a Use Year").tag(nil as UseYear?)
                            ForEach(availableUseYears, id: \.self) { useYear in
                                Text(useYear.rawValue)
                                    .lineLimit(1)
                                    .tag(useYear as UseYear?)
                            }
                        }
                    } label: {
                        Text(selectedUseYear?.rawValue ?? "Select a Use Year")
                            .lineLimit(1)
                    }
                }
            }
            .navigationTitle("Add a Contract")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let contractSize = Int(points) ?? 0
                        let contractExpireYear = getExpireYear(resort: selectedResort!)
                        let contract = Contract(resortId: selectedResort!.id, points: contractSize, useYear: selectedUseYear!, expirationYear: contractExpireYear)
                        modelContext.insert(contract)
                        
                        var vactionPointsYears: [VacationPoints] = []
                        let currentYear = Calendar.current.component(.year, from: Date())
                        for year in ((currentYear - 1)..<contractExpireYear) {
                            let vacationPoints = VacationPoints(year: year, contract: contract, points: contractSize)
                            
                            vactionPointsYears.append(vacationPoints)
                            modelContext.insert(vacationPoints)
                        }
                        
                        try? modelContext.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddContractView()
}
