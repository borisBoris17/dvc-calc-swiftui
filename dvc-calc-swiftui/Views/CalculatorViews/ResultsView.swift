//
//  ResultsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 10/06/2024.
//

import SwiftUI

struct ResultsView: View {
    @Binding var resort: Resort?
    @Binding var roomCategory: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var body: some View {
        if resort != nil {
            ForEach(resort!.roomTypes.sorted()) { roomType in
                if roomType.roomCategory == roomCategory || roomCategory == "" {
                    ForEach(roomType.viewTypes.sorted()) { viewType in
                        ViewTypePointsView(viewType: viewType, checkInDate: checkInDate, checkOutDate: checkOutDate)
                    }
                }
            }
        }
        
        Text("Results for \(resort?.resortName ?? "All Resorts") - \(roomCategory == "" ? "All Room Types" : roomCategory)")
    }
}

//#Preview {
//    ResultsView()
//}
