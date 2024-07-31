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
                .foregroundStyle(Color.font)
            
            ScrollView {
                ForEach(contracts) { contract in
                    ContractView(contract: contract, pointAllotmentYear: contract.useYear.getAllotmentYearByDate(date: Date()))
                        .padding()
                }
            }
            
            Button {
                showAddContract = true
            } label: {
                Text("Add Contract")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.secondaryFont)
                    .frame(maxWidth: .infinity)
                    .padding(7)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.accent)
                    )
                    .padding(.horizontal)
            }
            .padding(.bottom)
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
