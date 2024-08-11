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
    @State private var showEditContractName = false
    @State private var newName = ""
    
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
                        Text(contract.name)
                        Text(resorts[0].resortName)
                            .font(.footnote)
                            .fontWeight(.none)
                        Text("\(contract.useYear.rawValue)")
                            .font(.footnote)
                            .fontWeight(.none)
                    }
                }
                
                Spacer()
                
                Text("\(contract.points) pts")
            }
            .foregroundColor(Color.constantFont)
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
                                }
                            }
                        }
                    }
                }
            }
            .foregroundColor(Color.constantFont)
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
                            
                            withAnimation() {
                                isEditMode.toggle()
                            }
                        } catch {
                            print("Error Updating Vacation Point Ammounts", error)
                        }
                    }
                    .foregroundColor(Color.constantFont)
                    
                    Button("Edit Name") {
                        showEditContractName.toggle()
                    }
                    .foregroundColor(Color.constantFont)
                    .alert("Enter new contract name", isPresented: $showEditContractName) {
                        TextField("Enter new contract name", text: $newName)
                        Button("Okay") {
                            do {
                                contract.name = newName
                                try modelContext.save()
                            } catch {
                                print("Error Updating Contract Name", error)
                            }
                        }
                    }
                } else {
                    Button("Edit") {
                        for vacationPoints in contract.vactionPointsYears.sorted() {
                            if vacationPoints.year >= pointAllotmentYear - 1 && vacationPoints.year <= pointAllotmentYear + 1 {
                                updatedPointValues.append("\(vacationPoints.points)")
                            }
                        }
                        withAnimation() {
                            isEditMode.toggle()
                        }
                    }
                    .foregroundColor(Color.constantFont)
                }
                
                Spacer()
                
                if isEditMode {
                    Button("Cancel") {
                        withAnimation() {
                            isEditMode.toggle()
                        }
                    }
                    .foregroundColor(Color.constantFont)
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
                .foregroundColor(Color.secondaryBackground)
        )
    }
}

//#Preview {
//    ContractView()
//}
