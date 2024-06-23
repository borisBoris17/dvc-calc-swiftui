//
//  CalculatorView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import SwiftUI
import SwiftData
import HorizonCalendar

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
    
    let roomTypeCategories = [RoomCategory(name: "Studio", order: 0), RoomCategory(name: "One-Bedroom", order: 1), RoomCategory(name: "Two-Bedroom", order: 2), RoomCategory(name: "Three-Bedroom", order: 3)]
    
    private var formatedCheckInDate: String {
        checkInDate?.formatted(date: .long, time: .omitted) ?? "Check In Date"
    }
    
    private var formatedCheckOutDate: String {
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
                Image("logo")
                
                VStack {
                    HStack {
                        Text("Dates")
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    Button {
                        showDateInput.toggle()
                    } label: {
                        VStack {
                            
                            HStack {
                                Text("\(formatedCheckInDate) - \(formatedCheckOutDate)")
                                
                                Spacer()
                            }
                            .padding([.leading, .top])
                            
                            Divider()
                                .frame(height: 3)
                                .padding(.leading)
                                .background(Color.black)
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            Rectangle()
                                .foregroundStyle(.white.opacity(0.5))
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding([.horizontal, .bottom])
                
                VStack {
                    HStack {
                        Text("Resorts")
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    VStack {
                        NavigationLink(value: "Resorts") {
                            VStack {
                                HStack {
                                    Text(numSelectedResorts() == 0 ? "Select Resorts..." : numSelectedResorts() == 1 ? "1 Resort Selected" : "\(numSelectedResorts()) Resorts Selected")
                                        .padding([.leading, .top])
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                    .frame(height: 3)
                                    .padding(.leading)
                                    .background(Color.black)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .foregroundStyle(.white.opacity(0.5))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        path.append("Resorts")
                    }
                }
                .padding([.horizontal, .bottom])
                
                VStack {
                    HStack {
                        Text("Room Types")
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    VStack {
                        NavigationLink(value: "Room Types") {
                            VStack {
                                HStack {
                                    Text(numSelectedRoomTypes() == 0 ? "Select Room Types..." : numSelectedRoomTypes() == 1 ? "1 Room Type Selected" : "\(numSelectedRoomTypes()) Room Types Selected")
                                        .padding([.leading, .top])
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                    .frame(height: 3)
                                    .padding(.leading)
                                    .background(Color.black)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .foregroundStyle(.white.opacity(0.5))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        path.append("Room Types")
                    }
                }
                .padding([.horizontal, .bottom])
                
                NavigationLink {
                    ResultsView(resorts: $selectedResorts, roomCategory: $selectedRoomCategory, checkInDate: checkInDate ?? Date.now, checkOutDate: checkOutDate ?? Date.now)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("BackgroundColor"))
                } label: {
                    Text("Calculate")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Capsule())
                }
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "Resorts" {
                    ResortSelectView(resorts: $selectedResorts)
                } else {
                    RoomTypeSelectView(roomTypes: $selectedRoomCategories)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
            .onAppear() {
                if selectedResorts.count == 0 {
                    for resort in resorts {
                        selectedResorts[resort] = true
                        //                        selectedResortIndicies.append(false)
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
        }
    }
}

#Preview {
    @State var path = NavigationPath()
    
    return CalculatorView(path: $path)
}
