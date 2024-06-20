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
    @State private var selectedResorts: [Resort] = []
    @State private var selectedResortIndicies: [Bool] = []
    
    let roomTypeCategories = ["Studio", "One-Bedroom", "Two-Bedroom", "Three-Bedroom"]
    
    private var formatedCheckInDate: String {
        checkInDate?.formatted(date: .long, time: .omitted) ?? "Check In Date"
    }
    
    private var formatedCheckOutDate: String {
        checkOutDate?.formatted(date: .long, time: .omitted) ?? "Check Out Date"
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
                
                // Resorts as a Menu
                VStack {
                    HStack {
                        Text("Resorts")
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    VStack {
                        NavigationLink(value: "Reosrts") {
                            HStack {
                                Text("Resorts")
                                    .padding()
                                
                                Spacer()
                            }
                        }
                        .navigationDestination(for: String.self) { _ in
                            ResortSelectView(resorts: resorts, selectedIndexes: $selectedResortIndicies)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .foregroundStyle(.white.opacity(0.5))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        print("onTap...")
                        path.append("Resorts")
                    }
                    
                }
                .padding([.horizontal, .bottom])
                
                // Resorts as a Picker
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
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
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
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
            .onAppear() {
                if selectedResorts.count == 0 {
                    for resort in resorts {
                        selectedResorts.append(resort)
                        selectedResortIndicies.append(false)
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
