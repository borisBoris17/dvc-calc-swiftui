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
    
    let roomTypeCategories = ["Studio", "One-Bedroom", "Two-Bedroom", "Three-Bedroom"]
    
    private var formatedCheckInDate: String {
        checkInDate?.formatted(date: .long, time: .omitted) ?? "Check In Date"
    }
    
    private var formatedCheckOutDate: String {
        checkOutDate?.formatted(date: .long, time: .omitted) ?? "Check Out Date"
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
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
                }
                .padding([.horizontal, .bottom])
                
                VStack {
                    HStack {
                        Text("Resorts")
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    VStack {
                        HStack {
                            Picker(selection: $selectedResort, label: Text("Resort")) {
                                Text("All Resorts").tag(Optional<Resort>(nil))
                                ForEach(resorts) { resort in
                                    Text(resort.resortName).tag(Optional(resort))
                                }
                            }
                            .accentColor(.primary)
                            
                            Spacer()
                        }
                        
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
                .padding([.horizontal, .bottom])
                
                VStack {
                    HStack {
                        Text("Room Types")
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    VStack {
                        HStack {
                            Picker(selection: $selectedRoomCategory, label: Text("Room Types")) {
                                Text("All Types").tag("")
                                ForEach(roomTypeCategories, id: \.self) {
                                    Text($0).tag($0)
                                }
                            }
                            .accentColor(.primary)
                            
                            Spacer()
                        }
                        
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
                .padding([.horizontal, .bottom])
                
                NavigationLink {
                    ResultsView(resort: $selectedResort, roomCategory: $selectedRoomCategory, checkInDate: checkInDate ?? Date.now, checkOutDate: checkOutDate ?? Date.now)
                } label: {
                    Text("Calculate")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Capsule())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
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
