//
//  RoomTypeSelectView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 21/06/2024.
//

import SwiftUI

struct RoomTypeSelectView: View {
    @Binding var roomTypes: [RoomCategory : Bool]
    
    var body: some View {
        List {
            ForEach(roomTypes.sorted(by: { $0.key.order < $1.key.order }), id: \.key) { key, value in
                HStack {
                    Text(key.name)
                    
                    Spacer()
                    
                    Toggle(isOn: Binding(
                        get: { roomTypes[key] ?? false },
                        set: { newValue in
                            roomTypes[key] = newValue
                        }
                    )) {
                        // Empty label
                    }
                    .toggleStyle(iOSCheckboxToggleStyle())
                    .accentColor(.primary)
                }
            }
        }
    }
}
//
//#Preview {
//    RoomTypeSelectView()
//}
