//
//  RoomTypePointsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 17/06/2024.
//

import SwiftUI

struct RoomTypePointsView: View {
    var roomType: RoomType
    @Binding var roomCategorie: [RoomCategory : Bool]
    var roomCategory: String
    var checkInDate: Date
    var checkOutDate: Date
    
    var body: some View {
        VStack {
            ForEach(roomCategorie.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                if key.name == roomType.roomCategory && value {
                    HStack {
                        Rectangle()
                            .frame(width: 5)
                            .foregroundColor(.accent)
                        
                        VStack {
                            HStack {
                                Text(roomType.roomName)
                                    .font(.title2)
                                
                                Spacer()
                            }
                            
                            ForEach(roomType.viewTypes.sorted()) { viewType in
                                ViewTypePointsView(viewType: viewType, roomType: roomType, checkInDate: checkInDate, checkOutDate: checkOutDate)
                                    .padding(10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .foregroundColor(Color.secondaryBackground)
                                    )
                                    .padding(.bottom, roomType.viewTypes.sorted()[roomType.viewTypes.sorted().count - 1] == viewType ? 0 : nil)
                            }
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    RoomTypePointsView()
//}
