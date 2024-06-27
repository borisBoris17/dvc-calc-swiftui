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
        LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
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
                } header: {
                    
                    
                    HStack {
                        Text(resort.resortName)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.vertical)
                    .background(Color("BackgroundColor"))
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
