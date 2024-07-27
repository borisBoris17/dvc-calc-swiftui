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
    @State private var name = ""
    @State private var points = "200"
    @State private var selectedUseYear: UseYear? = nil
    
    @Query var resorts: [Resort] = []
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var availableUseYears: [UseYear] = [.February, .March, .April, .June, .August, .September, .October, .December]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Name")
                        
                        Spacer()
                        
                        TextField("Name", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                } footer: {
                    Text("Default name is resort name - points - use year")
                        .font(.footnote)
                }
                
                HStack {
                    Text("Home Resort")
                    
                    Spacer()
                    
                    Menu {
                        Picker(selection: $selectedResort, label: EmptyView()) {
                            Text("Select a Resort").tag(nil as Resort?)
                            ForEach(resorts.sorted()) { resort in
                                Text(resort.shortName)
                                    .lineLimit(1)
                                    .tag(resort as Resort?)
                            }
                        }
                    } label: {
                        Text(selectedResort?.shortName ?? "Select a Resort")
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
                        let contractExpireYear = Int(selectedResort!.expireYear)
                        let contractName = name.count > 0 ? name : "\(selectedResort!.shortName)-\(selectedUseYear!.rawValue.prefix(3))-\(points)"
                        let contract = Contract(resortId: selectedResort!.id, points: contractSize, useYear: selectedUseYear!, name: contractName)
                        modelContext.insert(contract)
                        
                        var vactionPointsYears: [VacationPoints] = []
                        let currentYear = selectedUseYear?.getAllotmentYearByDate(date: Date()) ?? Calendar.current.component(.year, from: Date())
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
