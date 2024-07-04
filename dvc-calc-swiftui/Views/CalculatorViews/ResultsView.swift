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
    
    @State var showDateInput = false
    
    @Binding var checkInDate: Date?
    @Binding var checkOutDate: Date?
    
    var body: some View {
        ScrollView {
            HStack {
                Button("Dates") {
                    showDateInput.toggle()
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundStyle(.white)
                .padding()
                .background(Capsule())
                
                NavigationLink(value: "Room Types") {
                    VStack {
                        Text("Room Types")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Capsule())
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(value: "Resorts") {
                    VStack {
                        Text("Resorts")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Capsule())
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
            ForEach(resorts.sorted(by: { $0.key.resortName < $1.key.resortName }), id: \.key) { (key, value) in
                if value && checkInDate != nil && checkOutDate != nil {
                    ResortPointsView(resort: key, roomCategorie: $roomCategories, roomCategory: roomCategory, checkInDate: checkInDate!, checkOutDate: checkOutDate!)
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
        .sheet(isPresented: $showDateInput) {
            CalendarView(checkInDate: $checkInDate, checkOutDate: $checkOutDate)
                .presentationDetents([.medium])
        }
    }
}

//#Preview {
//    ResultsView()
//}
