//
//  ContractView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 06/07/2024.
//

import SwiftUI
import SwiftData

struct ContractView: View {
    @State private var showDeleteAlert = false
    @State private var isEditMode = false
    @State private var updatedPointValues: [String] = []
    
    var contract: Contract
    var pointAllotmentYear: Int
    @Query private var resorts: [Resort] = []
    
    @Environment(\.modelContext) var modelContext
    
    init(contract: Contract, pointAllotmentYear: Int) {
        self.contract = contract
        self.pointAllotmentYear = pointAllotmentYear
        let resortId = contract.resortId
        
        self._resorts = Query(filter: #Predicate<Resort> {
            $0.id == resortId
        }, sort: \.resortName)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                if resorts.count > 0 {
                    VStack(alignment: .leading) {
                        Text(resorts[0].resortName)
                        Text("\(contract.useYear.rawValue)")
                            .font(.footnote)
                            .fontWeight(.none)
                    }
                }
                
                Spacer()
                
                Text("\(contract.points) pts")
            }
            .font(.title)
            .fontWeight(.bold)
            .padding([.horizontal, .top])
            
            VStack {
                Text("Vacation Points")
                    .font(.headline)
                
                if contract.vactionPointsYears.count > 0 {
                    ForEach(contract.vactionPointsYears.sorted().indices) { index in
                        if contract.vactionPointsYears.sorted()[index].year >= pointAllotmentYear - 1 && contract.vactionPointsYears.sorted()[index].year <= pointAllotmentYear + 1 {
                            HStack {
                                Text("\(String(contract.vactionPointsYears.sorted()[index].year))")
                                
                                Spacer()
                                
                                if isEditMode {
                                    TextField("Points", text: $updatedPointValues[index])
                                        .textFieldStyle(.roundedBorder)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.numberPad)
                                } else {
                                    Text("\(contract.vactionPointsYears.sorted()[index].points)")
                                        .padding(7)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            HStack {
                if isEditMode {
                    Button("Save") {
                        do {
                            for index in contract.vactionPointsYears.sorted().indices {
                                if index < updatedPointValues.count {
                                    contract.vactionPointsYears.sorted()[index].points = Int(updatedPointValues[index]) ?? 0
                                }
                            }
                            try modelContext.save()
                            
                            isEditMode.toggle()
                        } catch {
                            print("Error Updating Vacation Point Ammounts", error)
                        }
                    }
                } else {
                    Button("Edit Vacation Points") {
                        for vacationPoints in contract.vactionPointsYears.sorted() {
                            if vacationPoints.year >= pointAllotmentYear - 1 && vacationPoints.year <= pointAllotmentYear + 1 {
                                updatedPointValues.append("\(vacationPoints.points)")
                            }
                        }
                        
                        isEditMode.toggle()
                    }
                }
                
                Spacer()
                
                if isEditMode {
                    Button("Cancel") {
                        isEditMode.toggle()
                    }
                } else {
                    Button("Remove", role: .destructive) {
                        showDeleteAlert = true
                    }
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Are you sure you want to delete this Contract?"),
                            message: Text("This is a permanent action and will effect Trips using this Contract."),
                            primaryButton: .destructive(Text("Delete")) {
                                do {
                                    let fetchDescriptor = FetchDescriptor<Trip>()
                                    let trips = try modelContext.fetch(fetchDescriptor)
                                    
                                    for trip in trips {
                                        trip.contract = nil
                                    }
                                } catch {
                                    print("Error updating Trips linked to deleted Contract", error)
                                }
                                
                                modelContext.delete(contract)
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(.white)
                .shadow(radius: 5)
        )
    }
}

//#Preview {
//    ContractView()
//}
