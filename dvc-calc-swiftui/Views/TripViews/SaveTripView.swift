//
//  SaveTripView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 16/07/2024.
//

import SwiftUI
import SwiftData

struct SaveTripView: View {
    var checkInDate: Date
    var checkOutDate: Date
    var points: Int16
    var resortId: UUID
    var roomTypeId: UUID
    var viewTypeId: UUID
    
    @State private var selectedContract: Contract? = nil
    @State private var pointsBorrowedFromLastYear = ""
    @State private var pointsBorrowedFromNextYear = ""
    @Query var contracts: [Contract] = []
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Contract")
                    
                    Spacer()
                    
                    Menu {
                        Picker(selection: $selectedContract, label: EmptyView()) {
                            Text("Select a Contract").tag(nil as Contract?)
                            ForEach(contracts.sorted()) { contract in
                                Text(contract.name)
                                    .lineLimit(1)
                                    .tag(contract as Contract?)
                            }
                        }
                    } label: {
                        Text(selectedContract?.name ?? "Select a Contract")
                            .lineLimit(1)
                    }
                }
                
                HStack {
                    Text("Points Borrowed From Last Year")
                    
                    Spacer()
                    
                    TextField("Points Borrowed From Last Year", text: $pointsBorrowedFromLastYear)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
                
                HStack {
                    Text("Points Borrowed From Next Year")
                    
                    Spacer()
                    
                    TextField("Points Borrowed From Last Year", text: $pointsBorrowedFromLastYear)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Save Trip")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let fromLastYear = Int(pointsBorrowedFromLastYear) ?? 0
                        let fromNextYear = Int(pointsBorrowedFromNextYear) ?? 0
                        let trip = Trip(resortId: resortId, roomTypeId: roomTypeId, viewTypeId: viewTypeId, checkInDate: checkInDate, checkOutDate: checkOutDate, points: points, contract: selectedContract)
                        modelContext.insert(trip)
                        
                        // TODO: update the VacationPoints on the Contract
                        
                        try? modelContext.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

//#Preview {
//    SaveTripView()
//}
