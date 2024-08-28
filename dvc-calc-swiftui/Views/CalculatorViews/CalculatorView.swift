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
    @Query var resortAreas: [ResortArea]
    
    @Binding var path: NavigationPath
    
    @State private var showDateInput = false
    @State private var checkInDate: Date? = nil
    @State private var checkOutDate: Date? = nil
    @State private var selectedResort: Resort? = nil
    @State private var selectedResorts: [ResortArea : [Resort: Bool]] = [:]
    @State private var selectedRoomCategories: [RoomCategory: Bool] = [:]
    @State private var selectedResortIndicies: [Bool] = []
    @State private var showSelectResort = false
    @State private var showSelectRoomType = false
    @State private var numberOfSelectedResorts: Int = 0
    
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
            for (_, selected) in value {
                if selected {
                    countSelectedResorts += 1
                }
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
                                    .foregroundStyle(Color.constantFont)
                                
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
                .padding(.bottom, 10)
                
                VStack {
                    HStack {
                        Text("Resorts")
                            .foregroundStyle(Color.font)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    VStack {
                        Button {
                            showSelectResort.toggle()
                        } label: {
                            VStack {
                                HStack(alignment: .center) {
                                    Image(systemName: "building.2")
                                        .offset(x: 12, y: 0)
                                        .alignmentGuide(VerticalAlignment.center) { d in d[VerticalAlignment.top] }
                                        .foregroundStyle(Color.constantFont)
                                    
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
                .padding(.bottom, 10)
                
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
                                        .foregroundStyle(Color.constantFont)
                                    
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
                .padding(.bottom, 10)
                
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
                        .opacity(checkInDate == nil || checkOutDate == nil || numSelectedResorts() == 0 || numSelectedRoomTypes() == 0 ? 0.5 : 1)
                }
                .disabled(checkInDate == nil || checkOutDate == nil || numSelectedResorts() == 0 || numSelectedRoomTypes() == 0)
                
                Spacer()
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "Results" {
                    ResultsView(resorts: $selectedResorts, roomCategories: $selectedRoomCategories, checkInDate: $checkInDate, checkOutDate: $checkOutDate)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("BackgroundColor"))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
            .onAppear() {
                if selectedResorts.count == 0 {
                    for resortArea in resortAreas {
                        selectedResorts[resortArea] = [:]
                        for resort in resortArea.resorts {
                            selectedResorts[resortArea]?[resort] = true
                            numberOfSelectedResorts += 1
                        }
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
//                .presentationDetents([.fraction(0.9)])
                .presentationBackground(Color.background)
        }
        .sheet(isPresented: $showSelectResort) {
            SheetGroupedListView(options: $selectedResorts, title: "Resorts")
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
    @Previewable @State var path = NavigationPath()
    
    return CalculatorView(path: $path)
}
