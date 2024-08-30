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
    var points: Int
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
                            Text("Save Without Contract").tag(nil as Contract?)
                            ForEach(contracts.sorted()) { contract in
                                Text(contract.name)
                                    .lineLimit(1)
                                    .tag(contract as Contract?)
                            }
                        }
                    } label: {
                        Text(selectedContract?.name ?? "Save Without Contract")
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
                    
                    TextField("Points Borrowed From Last Year", text: $pointsBorrowedFromNextYear)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
            }
            .foregroundStyle(Color.font)
            .navigationTitle("Save Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let fromLastYear = Int(pointsBorrowedFromLastYear) ?? 0
                        let fromNextYear = Int(pointsBorrowedFromNextYear) ?? 0
                        let trip = Trip(resortId: resortId, roomTypeId: roomTypeId, viewTypeId: viewTypeId, checkInDate: checkInDate, checkOutDate: checkOutDate, points: points, borrowedFromLastYear: fromLastYear, borrowedFromNextYear: fromNextYear, contract: selectedContract)
                        modelContext.insert(trip)
                        
                        if let selectedContract = selectedContract {
                            let activeUseYear = selectedContract.useYear.getAllotmentYearByDate(date: Date())
                            for vacationPoints in selectedContract.vactionPointsYears.sorted() {
                                if vacationPoints.year >= activeUseYear - 1 && vacationPoints.year <= activeUseYear + 1 {
                                    if vacationPoints.year == activeUseYear - 1 {
                                        vacationPoints.points = vacationPoints.points - fromLastYear
                                    } else if vacationPoints.year == activeUseYear {
                                        vacationPoints.points = vacationPoints.points - (Int(points) - fromLastYear - fromNextYear)
                                    } else {
                                        vacationPoints.points = vacationPoints.points - fromNextYear
                                    }
                                }
                            }
                        }
                        
                        try? modelContext.save()
                        dismiss()
                    }
                    .foregroundStyle(Color.font)
                }
            }
        }
    }
}

//#Preview {
//    SaveTripView()
//}
