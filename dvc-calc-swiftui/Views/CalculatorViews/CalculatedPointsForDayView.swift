//
//  CalculatedPointsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 10/06/2024.
//

import SwiftUI
import SwiftData

struct CalculatedPointsForDayView: View {
    @Query private var pointValues: [PointValue]
    
    var showDetails: Bool
    var viewType: ViewType
    var nightToStay: Date
    @Binding var total: Int16
    
    
    init(showDetails: Bool, viewType: ViewType, nightToStay: Date, total: Binding<Int16>) {
        self.showDetails = showDetails
        self.viewType = viewType
        let viewTypeId = viewType.id
        self._pointValues = Query(filter: #Predicate<PointValue> {
            $0.viewType.id == viewTypeId && $0.startDate <= nightToStay && $0.endDate >= nightToStay
        }, sort: \.weekdayRate)
        
        self.nightToStay = nightToStay
        self._total = total
    }
    
    var body: some View {
        VStack {
            if showDetails {
                ForEach(pointValues) { pointValue in
                    HStack {
                        Text(nightToStay.numericFormattedDate)
                        
                        Spacer()
                        
                        Text("\(nightToStay.isFridaySaturday ? pointValue.weekendRate : pointValue.weekdayRate)")
                    }
                    
                }
            }
        }
        .onAppear() {
            if pointValues.count > 0 {
                if nightToStay.isFridaySaturday {
                    total = total + pointValues[0].weekendRate
                } else {
                    total = total + pointValues[0].weekdayRate
                }
            }
        }
    }
}

//#Preview {
//    CalculatedPointsView()
//}
