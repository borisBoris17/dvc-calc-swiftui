//
//  ContractView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 06/07/2024.
//

import SwiftUI
import SwiftData

struct ContractView: View {
    var contract: Contract
    @Query private var resorts: [Resort] = []
    
    
    
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
                    if vactionPoints.year < 2027 {
                        HStack {
                            Text("\(String(vactionPoints.year))")
                            
                            Spacer()
                            
                            Text("\(vactionPoints.points)")
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
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
