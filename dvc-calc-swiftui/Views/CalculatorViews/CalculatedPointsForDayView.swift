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
    
    var viewType: ViewType
    var nightToStay: Date
    @Binding var total: Int16
    
    init(viewType: ViewType, nightToStay: Date, total: Binding<Int16>) {
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
            ForEach(pointValues) { pointValue in
                if nightToStay.isFridaySaturday {
                    HStack {
                        Text(nightToStay.numericFormattedDate)
                        
                        Spacer()
                        
                        Text("\(pointValue.weekendRate)")
                    }
                } else {
                    HStack {
                        Text(nightToStay.numericFormattedDate)
                        
                        Spacer()
                        
                        Text("\(pointValue.weekdayRate)")
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
