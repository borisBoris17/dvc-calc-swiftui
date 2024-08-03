//
//  CalculatorView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import SwiftUI
import SwiftData

struct CalculatorView: View {
    
    @Query var resorts: [Resort]
    
    @Binding var path: NavigationPath
    
    @State private var showDateInput = false
    @State private var checkInDate: Date? = nil
    @State private var checkOutDate: Date? = nil
    @State private var selectedResort: Resort? = nil
    @State private var selectedRoomCategory = ""
    @State private var selectedResorts: [Resort: Bool] = [:]
    @State private var selectedRoomCategories: [RoomCategory: Bool] = [:]
    @State private var selectedResortIndicies: [Bool] = []
    @State private var showSelectResort = false
    @State private var showSelectRoomType = false
    
    @Environment(\.colorScheme) var colorScheme
    
    let roomTypeCategories = [RoomCategory(name: "Studio", order: 0), RoomCategory(name: "One-Bedroom", order: 1), RoomCategory(name: "Two-Bedroom", order: 2), RoomCategory(name: "Three-Bedroom", order: 3)]
    
    var formatedCheckInDate: String {
        checkInDate?.formatted(date: .long, time: .omitted) ?? "Check In Date"
    }
    
    var formatedCheckOutDate: String {
        checkOutDate?.formatted(date: .long, time: .omitted) ?? "Check Out Date"
    }
    
    func numSelectedResorts() -> Int {
        var countSelectedResorts = 0
        for value in selectedResorts.values {
            if value {
                countSelectedResorts += 1
            }
        }
        return countSelectedResorts
    }
    
    func numSelectedRoomTypes() -> Int {
        var countSelectedRoomCategories = 0
        for value in selectedRoomCategories.values {
            if value {
                countSelectedRoomCategories += 1
            }
        }
        return countSelectedRoomCategories
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                
                Image(colorScheme == .dark ? "logoDark" : "logo")
                
                Spacer()
                
                Spacer()
                
                Spacer()
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Dates")
                            .foregroundStyle(Color.font)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    Button {
                        showDateInput.toggle()
                    } label: {
                        VStack {
                            HStack(alignment: .center) {
                                Image(systemName: "calendar")
                                    .offset(x: 12, y: 0)
                                    .alignmentGuide(VerticalAlignment.center) { d in d[VerticalAlignment.top] }
                                
                                Text("\(formatedCheckInDate) - \(formatedCheckOutDate)")
                                    .foregroundStyle(Color.constantFont)
                                    .padding([.leading, .top])
                                
                                Spacer()
                            }
                            
                            Divider()
                                .frame(height: 3)
                                .padding(.leading)
                                .background(Color.font)
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            Rectangle()
                                .foregroundStyle(Color.secondaryBackground)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Text("Resorts")
                            .foregroundStyle(Color.font)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    VStack {
                        Button {
                            
                        } label: {
                            VStack {
                                HStack(alignment: .center) {
                                    Image(systemName: "building.2")
                                        .offset(x: 12, y: 0)
                                        .alignmentGuide(VerticalAlignment.center) { d in d[VerticalAlignment.top] }
                                    
                                    Text(numSelectedResorts() == 0 ? "Select Resorts..." : numSelectedResorts() == 1 ? "1 Resort Selected" : "\(numSelectedResorts()) Resorts Selected")
                                        .foregroundStyle(Color.constantFont)
                                        .padding([.leading, .top])
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                    .frame(height: 3)
                                    .padding(.leading)
                                    .background(Color.font)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .foregroundStyle(Color.secondaryBackground)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        showSelectResort.toggle()
                    }
                }
                .padding(.horizontal)
                
                VStack {
                    HStack(alignment: .center) {
                        Text("Room Types")
                            .foregroundStyle(Color.font)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    VStack {
                        Button {
                            showSelectRoomType.toggle()
                        } label: {
                            VStack {
                                HStack(alignment: .center) {
                                    Image(systemName: "bed.double")
                                        .offset(x: 12, y: 0)
                                        .alignmentGuide(VerticalAlignment.center) { d in d[VerticalAlignment.top] }
                                    
                                    Text(numSelectedRoomTypes() == 0 ? "Select Room Types..." : numSelectedRoomTypes() == 1 ? "1 Room Type Selected" : "\(numSelectedRoomTypes()) Room Types Selected")
                                        .foregroundStyle(Color.constantFont)
                                        .padding([.leading, .top])
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                    .frame(height: 3)
                                    .background(Color.font)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .foregroundStyle(Color.secondaryBackground)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        showSelectRoomType.toggle()
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Spacer()
                
                NavigationLink(value: "Results") {
                    Text("Calculate")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.secondaryFont)
                        .frame(maxWidth: .infinity)
                        .padding(7)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.accent)
                        )
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "Results" {
                    ResultsView(resorts: $selectedResorts, roomCategories: $selectedRoomCategories, roomCategory: $selectedRoomCategory, checkInDate: $checkInDate, checkOutDate: $checkOutDate)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("BackgroundColor"))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
            .onAppear() {
                if selectedResorts.count == 0 {
                    for resort in resorts {
                        selectedResorts[resort] = true
                    }
                }
                if selectedRoomCategories.count == 0 {
                    for roomCategory in roomTypeCategories {
                        selectedRoomCategories[roomCategory] = true
                    }
                }
            }
        }
        .sheet(isPresented: $showDateInput) {
            CalendarView(checkInDate: $checkInDate, checkOutDate: $checkOutDate)
                .presentationDetents([.medium])
                .presentationBackground(Color.background)
        }
        .sheet(isPresented: $showSelectResort) {
            SheetListView(options: $selectedResorts, title: "Resorts")
                .presentationDetents([.large])
                .presentationBackground(Color.background)
        }
        .sheet(isPresented: $showSelectRoomType) {
            SheetListView(options: $selectedRoomCategories, title: "Room Types")
                .presentationDetents([.medium])
                .presentationBackground(Color.background)
        }
    }
}

#Preview {
    @State var path = NavigationPath()
    
    return CalculatorView(path: $path)
}
