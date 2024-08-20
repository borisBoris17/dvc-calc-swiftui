//
//  ResultsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 10/06/2024.
//

import SwiftUI

struct ResultsView: View {
    @Binding var resorts: [ResortArea :[Resort : Bool]]
    @Binding var roomCategories: [RoomCategory : Bool]
    
    @State var showDateInput = false
    @State private var showSelectResort = false
    @State private var showSelectRoomType = false
    
    @Binding var checkInDate: Date?
    @Binding var checkOutDate: Date?
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Button {
                        showDateInput.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "calendar")
                            
                            Text("Dates")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundStyle(Color.background)
                    .fontWeight(.bold)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.accent)
                    )
                    
                    Button {
                        showSelectResort.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "slider.vertical.3")
                            
                            Text("Resorts")
                        }
                        .foregroundStyle(Color.background)
                        .fontWeight(.bold)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.accent)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button {
                        showSelectRoomType.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "slider.vertical.3")
                            
                            Text("Room Types")
                        }
                        .foregroundStyle(Color.background)
                        .fontWeight(.bold)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.accent)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .scrollIndicators(.hidden)
            .padding(.leading)
            
            ScrollView {
                ForEach(resorts.sorted(by: { $0.key < $1.key }), id: \.key) { key1, _ in
//                    VStack {
                        ForEach(resorts[key1]?.sorted(by: { $0.key.resortName < $1.key.resortName }) ?? [], id: \.key) { (key2, value) in
                            if value && checkInDate != nil && checkOutDate != nil {
                                ResortPointsView(resort: key2, roomCategorie: $roomCategories, checkInDate: checkInDate!, checkOutDate: checkOutDate!)
                            }
                        }
//                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .sheet(isPresented: $showDateInput) {
            CalendarView(checkInDate: $checkInDate, checkOutDate: $checkOutDate)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showSelectResort) {
            SheetGroupedListView(options: $resorts, title: "Resorts")
                .presentationDetents([.large])
                .presentationBackground(Color.background)
        }
        .sheet(isPresented: $showSelectRoomType) {
            SheetListView(options: $roomCategories, title: "Room Types")
                .presentationDetents([.large])
                .presentationBackground(Color.background)
        }
    }
}

//#Preview {
//    ResultsView()
//}
