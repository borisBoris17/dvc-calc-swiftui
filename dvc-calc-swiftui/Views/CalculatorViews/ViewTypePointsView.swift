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
            HStack {
                VStack {
                    Text(viewType.viewName)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    Text("\(totalPointsForStay)")
                        .font(.title)
//                        .fontWeight(.bold)
                        .padding(.bottom, -10)
                    
                    Text("points")
                        .font(.subheadline)
                }
            }
            .padding(.bottom)
            
            ForEach(dateRange, id: \.self) { night in
                CalculatedPointsForDayView(viewType: viewType, nightToStay: night, total: $totalPointsForStay)
            }
            .padding(.leading)
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
