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
    @State private var isLoading = false
    
    @Binding var checkInDate: Date?
    @Binding var checkOutDate: Date?
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Button {
                        isLoading = true
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
                        isLoading = true
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
                        isLoading = true
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
                    ForEach(resorts[key1]?.sorted(by: { $0.key.resortName < $1.key.resortName }) ?? [], id: \.key) { (key2, value) in
                        if value && checkInDate != nil && checkOutDate != nil {
                            ResortPointsView(resort: key2, roomCategorie: $roomCategories, checkInDate: checkInDate!, checkOutDate: checkOutDate!)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .loadingView(isLoading: isLoading) {
            VStack {
                Section {
                    HStack {
                        Rectangle()
                            .frame(width: 5)
                            .foregroundColor(.accent)
                        
                        VStack {
                            ForEach(0..<5) { _ in
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(Color.secondaryBackground)
                                    .frame(maxWidth: .infinity, minHeight: 70)
                            }
                            .padding(.leading, 3)
                            .padding(.trailing)
                            .padding(.vertical, 10)
                        }
                    }
                    .padding(.leading)
                } header: {
                    HStack {
                        Text("")
                            .foregroundStyle(Color.background)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 70)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.accent)
                }
            }
            .padding(.top, 5)
        }
        .sheet(isPresented: $showDateInput, onDismiss: {
            isLoading = false
        }) {
            CalendarView(checkInDate: $checkInDate, checkOutDate: $checkOutDate)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showSelectResort, onDismiss: {
            isLoading = false
        }) {
            SheetGroupedListView(options: $resorts, title: "Resorts")
                .presentationDetents([.large])
                .presentationBackground(Color.background)
        }
        .sheet(isPresented: $showSelectRoomType, onDismiss: {
            isLoading = false
        }) {
            SheetListView(options: $roomCategories, title: "Room Types")
                .presentationDetents([.large])
                .presentationBackground(Color.background)
        }
    }
}

//#Preview {
//    ResultsView()
//}
