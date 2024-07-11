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
    
    var contract: Contract
    @Query private var resorts: [Resort] = []
    
    let thisYear = Calendar.current.component(.year, from: Date())
    
    @Environment(\.modelContext) var modelContext
    
    init(contract: Contract) {
        self.contract = contract
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
                
                ForEach(contract.vactionPointsYears.sorted()) { vactionPoints in
                    if vactionPoints.year >= thisYear - 1 && vactionPoints.year <= thisYear + 1 {
                        HStack {
                            Text("\(String(vactionPoints.year))")
                            
                            Spacer()
                            
                            Text("\(vactionPoints.points)")
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                
                Button("Remove", role: .destructive) {
                    showDeleteAlert = true
                }
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("Are you sure you want to delete this Contract?"),
                        message: Text("This is a permanent action and will effect Trips using this Contract."),
                        primaryButton: .destructive(Text("Delete")) {
                            modelContext.delete(contract)
                        },
                        secondaryButton: .cancel()
                    )
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
