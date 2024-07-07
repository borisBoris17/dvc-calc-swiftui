//
//  ResortPointsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 17/06/2024.
//

import SwiftUI

struct ResortPointsView: View {
    var resort: Resort
    @Binding var roomCategorie: [RoomCategory : Bool]

    var roomCategory: String
    var checkInDate: Date
    var checkOutDate: Date
    
    @State var hasRoomsToShow = false
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
            if hasRoomsToShow {
                Section {
                    ForEach(resort.roomTypes.sorted()) { roomType in
                        VStack {
                            if roomType.roomCategory == roomCategory || roomCategory == "" {
                                VStack {
                                    RoomTypePointsView(roomType: roomType, roomCategorie: $roomCategorie, roomCategory: roomCategory, checkInDate: checkInDate, checkOutDate: checkOutDate)
                                }
                            }
                        }
                    }
                    .padding()
                } header: {
                    HStack {
                        Text(resort.resortName)
                            .foregroundStyle(Color.background)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.accent)
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
