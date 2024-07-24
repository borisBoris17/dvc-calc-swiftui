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
    @State private var showAddContract = false
    
    @Query private var contracts: [Contract] = []
    
    var body: some View {
        VStack {
            Text("Contracts")
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView {
                ForEach(contracts) { contract in
                    ContractView(contract: contract, pointAllotmentYear: contract.useYear.getAllotmentYearByDate(date: Date()))
                        .padding()
                }
                
                Button("Add Contract") {
                    showAddContract = true
                }
            }
        }
        .sheet(isPresented: $showAddContract) {
            AddContractView()
                .presentationDetents([.medium])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
    }
}

#Preview {
    ContractsView()
}
