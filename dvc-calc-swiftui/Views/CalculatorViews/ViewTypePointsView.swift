//
//  ViewTypePointsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 15/06/2024.
//

import SwiftUI

struct ViewTypePointsView: View {
    @Environment(\.modelContext) var modelContext
    
    var viewType: ViewType
    var roomType: RoomType
    var checkInDate: Date
    var checkOutDate: Date
    
    @State private var dateRange: [Date] = []
    @State private var totalPointsForStay: Int = 0
    @State private var showDetails = true
    @State private var showSaveTrip = false
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(viewType.viewName.count > 0 ? viewType.viewName : "Standard")
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    Text("\(totalPointsForStay)")
                        .font(.title)
                        .padding(.bottom, -10)
                    
                    Text("points")
                        .font(.subheadline)
                }
            }
            .padding(.bottom)
            
            
            VStack {
                HStack {
                    Button(showDetails ? "Close Deatils" : "Details") {
                        showDetails.toggle()
                    }
                    .font(.subheadline)
                    .underline()
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button("Save") {
                        showSaveTrip.toggle()
                    }
                }
                
                ForEach(dateRange, id: \.self) { night in
                    CalculatedPointsForDayView(showDetails: showDetails, viewType: viewType, nightToStay: night, total: $totalPointsForStay)
                }
            }
            .padding(.leading)
        }
        .onAppear() {
            if dateRange.count == 0 {
                var night = checkInDate
                while (night < checkOutDate){
                    dateRange.append(night)
                    night = Calendar.current.date(byAdding: .day, value: 1, to: night)!
                }
            } else {
                totalPointsForStay = 0
            }
            showDetails = false
        }
        .sheet(isPresented: $showSaveTrip) {
            SaveTripView(checkInDate: checkInDate, checkOutDate: checkOutDate, points: totalPointsForStay, resortId: roomType.resortId, roomTypeId: roomType.id, viewTypeId: viewType.id)
        }
    }
}

//#Preview {
//    ViewTypePointsView()
//}
