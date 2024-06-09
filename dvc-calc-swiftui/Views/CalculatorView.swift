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
    
    @State private var showDateInput = false
    @State private var checkInDate: Date? = nil
    @State private var checkOutDate: Date? = nil
    @State private var selectedResort: Resort? = nil
    
    private var formatedCheckInDate: String {
        checkInDate?.formatted(date: .long, time: .omitted) ?? "Check In Date"
    }
    
    private var formatedCheckOutDate: String {
        checkOutDate?.formatted(date: .long, time: .omitted) ?? "Check Out Date"
    }
    
    var body: some View {
        ScrollView {
            Image("logo")
            
            VStack {
                HStack {
                    Text("Dates")
                    
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
            .padding()
            
            VStack {
                HStack {
                    Text("Resorts")
                    
                    Spacer()
                }
                VStack {
                    HStack {
                        Picker(selection: $selectedResort, label: Text("Resort")) {
                            Text("All Resorts").tag(Optional<Resort>(nil))
                            ForEach(resorts) { resort in
                                Text(resort.resortName).tag(Optional(resort))
                                //                            .frame(minWidth: .infinity)
                            }
                        }
                        .accentColor(.primary)
                        //                .pickerStyle(.navigationLink)
                        
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
            .padding()
            
//            ForEach(resorts) { resort in
//                VStack {
//                    Text("\(resort.resortName)")
//                    
//                    ForEach(resort.roomTypes.sorted()) { roomType in
//                        Text("\(roomType.roomName)")
//                        ForEach(roomType.viewTypes.sorted()) { viewType in
//                            Text(viewType.viewName)
//                        }
//                    }
//                }
//                Spacer()
//            }
        }
        //        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("BackgroundColor"))
        .sheet(isPresented: $showDateInput) {
            CalendarView(checkInDate: $checkInDate, checkOutDate: $checkOutDate)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    CalculatorView()
}
