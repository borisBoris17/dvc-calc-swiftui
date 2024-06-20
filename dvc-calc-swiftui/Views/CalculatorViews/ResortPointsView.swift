//
//  ResortPointsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 17/06/2024.
//

import SwiftUI

struct ResortPointsView: View {
    var resort: Resort
    var roomCategory: String
    var checkInDate: Date
    var checkOutDate: Date
    
    @State var hasRoomsToShow = false
    
    var body: some View {
        VStack {
            if hasRoomsToShow {
                VStack {
                    HStack {
                        Text(resort.resortName)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    ForEach(resort.roomTypes.sorted()) { roomType in
                        VStack {
                            if roomType.roomCategory == roomCategory || roomCategory == "" {
                                VStack {
                                    RoomTypePointsView(roomType: roomType, roomCategory: roomCategory, checkInDate: checkInDate, checkOutDate: checkOutDate)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear() {
            for roomType in resort.roomTypes {
                if roomType.roomCategory == roomCategory || roomCategory == "" {
                    hasRoomsToShow = true
                }
            }
        }
    }
}

//#Preview {
//    ResortPointsView()
//}
