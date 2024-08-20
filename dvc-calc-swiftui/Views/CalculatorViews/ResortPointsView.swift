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
    
    var checkInDate: Date
    var checkOutDate: Date
    
    @State var hasRoomsToShow = false
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
            if hasRoomsToShow {
                Section {
                    ForEach(resort.roomTypes.sorted()) { roomType in
                        RoomTypePointsView(roomType: roomType, roomCategorie: $roomCategorie, checkInDate: checkInDate, checkOutDate: checkOutDate)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
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
                for (roomCat, selected) in roomCategorie {
                    if roomType.roomCategory == roomCat.name && selected {
                        hasRoomsToShow = true
                    }
                }
            }
        }
    }
}

//#Preview {
//    ResortPointsView()
//}
