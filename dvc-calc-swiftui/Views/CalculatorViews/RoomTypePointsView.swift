//
//  RoomTypePointsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 17/06/2024.
//

import SwiftUI

struct RoomTypePointsView: View {
    var roomType: RoomType
    var roomCategory: String
    var checkInDate: Date
    var checkOutDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Text(roomType.roomName)
                    .font(.title2)
                
                Spacer()
            }
            ForEach(roomType.viewTypes.sorted()) { viewType in
                ViewTypePointsView(viewType: viewType, checkInDate: checkInDate, checkOutDate: checkOutDate)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    )
                    .padding(.bottom)
            }
        }
    }
}

//#Preview {
//    RoomTypePointsView()
//}
