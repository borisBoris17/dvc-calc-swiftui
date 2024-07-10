//
//  Contracts.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import SwiftUI
import SwiftData

struct ContractsView: View {
    @Query(filter: #Predicate<Resort> { resort in
        resort.resortName.starts(with: "Disney's Riviera Resort")
    }) private var resorts: [Resort] = []
    
    @Query private var contracts: [Contract] = []
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            Text("Contracts")
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView {
                ForEach(contracts) { contract in
                    ContractView(contract: contract)
                        .padding()
                }
                
                Button("Add Contract") {
                    let contractSize: Int = 200
                    let contractUseYear: UseYear = .February
                    let contract = Contract(resortId: resorts[0].id, points: contractSize, useYear: contractUseYear, expirationYear: 2070)
                    modelContext.insert(contract)
                    
                    var vactionPointsYears: [VacationPoints] = []
                    let currentYear = Calendar.current.component(.year, from: Date())
                    for year in ((currentYear - 1)..<2041) {
                        let vacationPoints = VacationPoints(year: year, contract: contract, points: contractSize)
                        
                        vactionPointsYears.append(vacationPoints)
                        modelContext.insert(vacationPoints)
                    }
                                        
                    try? modelContext.save()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
    }
}

#Preview {
    ContractsView()
}
