//
//  RoomTypeSelectView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 21/06/2024.
//

import SwiftUI

struct RoomTypeSelectView: View {
    @Binding var roomTypes: [RoomCategory : Bool]
    @State private var selectAll = false
    
    func isAllTypesSelected() -> Bool {
        let selectedRoomTypes = roomTypes.filter { $0.value == true }
        return roomTypes.count == selectedRoomTypes.count
    }
    
    var body: some View {
        List {
            HStack {
                Text(isAllTypesSelected() ? "Deselect All" : "Select All")
                
                Spacer()
                
                Toggle(isOn: $selectAll) {
                    // Empty label
                }
                .toggleStyle(iOSCheckboxToggleStyle())
                .accentColor(.primary)
                .onChange(of: selectAll) {
                    if isAllTypesSelected() {
                        for (key, _) in roomTypes {
                            roomTypes[key] = false
                        }
                    } else {
                        for (key, _) in roomTypes {
                            roomTypes[key] = true
                        }
                    }
                }
            }
            
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
        .onAppear() {
            if isAllTypesSelected() {
                selectAll = true
            }
        }
        .navigationTitle("Room Types")
    }
}
//
//#Preview {
//    RoomTypeSelectView()
//}
