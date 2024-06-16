//
//  ViewTypePointsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 15/06/2024.
//

import SwiftUI

struct ViewTypePointsView: View {
    var viewType: ViewType
    var checkInDate: Date
    var checkOutDate: Date
    
    @State private var dateRange: [Date] = []
    @State private var totalPointsForStay: Int16 = 0
    
    var body: some View {
        VStack {
            Text("Total: \(totalPointsForStay)")
            ForEach(dateRange, id: \.self) { night in
                CalculatedPointsForDayView(viewType: viewType, nightToStay: night, total: $totalPointsForStay)
            }
        }
        .onAppear() {
            var night = checkInDate
            while (night < checkOutDate){
                dateRange.append(night)
                night = Calendar.current.date(byAdding: .day, value: 1, to: night)!
            }
        }
    }
}

//#Preview {
//    ViewTypePointsView()
//}
