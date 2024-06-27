//
//  ResultsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 10/06/2024.
//

import SwiftUI

struct ResultsView: View {
    @Binding var resorts: [Resort : Bool]
    @Binding var roomCategories: [RoomCategory : Bool]
    
    @Binding var roomCategory: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    
    var body: some View {
        ScrollView {
            HStack {
                NavigationLink(value: "Room Types") {
                    VStack {
                        Text("Room Types")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Capsule())
                    }
                }
                
                NavigationLink(value: "Resorts") {
                    VStack {
                        Text("Resorts")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Capsule())
                    }
                }
                
                Spacer()
            }
            ForEach(resorts.sorted(by: { $0.key.resortName < $1.key.resortName }), id: \.key) { (key, value) in
                if value {
                    ResortPointsView(resort: key, roomCategorie: $roomCategories, roomCategory: roomCategory, checkInDate: checkInDate, checkOutDate: checkOutDate)
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
    }
}

//#Preview {
//    ResultsView()
//}
