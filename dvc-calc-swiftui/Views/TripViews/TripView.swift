//
//  TripView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/07/2024.
//

import SwiftUI
import SwiftData

struct TripView: View {
    var trip: Trip
    
    @State private var showDeleteAlert = false
    
    @Query private var resorts: [Resort]
    @Query private var roomTypes: [RoomType]
    @Query private var viewTypes: [ViewType]
    
    @Environment(\.modelContext) var modelContext
    
    init(trip: Trip) {
        self.trip = trip
        let resortId = trip.resortId
        let roomTypeId = trip.roomTypeId
        let viewTypeId = trip.viewTypeId
        
        self._resorts = Query(filter: #Predicate<Resort> {
            $0.id == resortId
        })
        
        self._roomTypes = Query(filter: #Predicate<RoomType> {
            $0.id == roomTypeId
        })
        
        self._viewTypes = Query(filter: #Predicate<ViewType> {
            $0.id == viewTypeId
        })
    }
    
    var countDownString: String {
        let daysUntil = Date().startOfDay.daysUntil(date: trip.checkInDate)
        if daysUntil > 0 {
            return "\(daysUntil) Days"
        } else if daysUntil == 0 {
            return "Disney Day!"
        } else {
            return ""
        }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    if let resort = resorts.first {
                        Text(resort.resortName)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                    } else {
                        Text("No resort found.")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                    }
                 
                    Spacer()
                    
                    Text(countDownString)
                }
                .padding(.top)
                
                VStack(spacing: -10) {
                    HStack {
                        Text("Room Type:")
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        Spacer()
                        
                        if let roomType = roomTypes.first {
                            Text(roomType.roomName)
                                .font(.subheadline)
                                .padding(.bottom)
                        }
                    }
                    
                    HStack {
                        Text("View Type:")
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        Spacer()
                        
                        if let viewType = viewTypes.first {
                            Text(viewType.viewName)
                                .font(.subheadline)
                                .padding(.bottom)
                        }
                    }
                    
                    HStack {
                        Text("Check In Date: ")
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        Spacer()
                        
                        Text("\(trip.checkInDate.formatted(date: .numeric, time: .omitted))")
                            .font(.subheadline)
                            .padding(.bottom)
                    }
                    
                    HStack {
                        Text("Check Out Date: ")
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        Spacer()
                        
                        Text("\(trip.checkOutDate.formatted(date: .numeric, time: .omitted))")
                            .font(.subheadline)
                            .padding(.bottom)
                    }
                    
                    HStack {
                        Text("Points: ")
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        Spacer()
                        
                        Text("\(trip.points)")
                            .font(.subheadline)
                            .padding(.bottom)
                    }
                    
                    HStack {
                        Text("Contract: ")
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        Spacer()
                        
                        Text(trip.contract?.name ?? "No Contract")
                            .font(.subheadline)
                            .padding(.bottom)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button("Remove", role: .destructive) {
                            showDeleteAlert = true
                        }
                        .padding(.bottom)
                        .alert(isPresented: $showDeleteAlert) {
                            Alert(
                                title: Text("Are you sure you want to delete this Trip?"),
                                message: Text(trip.contract != nil ? "This is a permanent action and will effect the Contract on this Trip." : "This is a permanent action"),
                                primaryButton: .destructive(Text("Delete")) {
                                    if let contract = trip.contract {
                                        let allotmentYear = contract.useYear.getAllotmentYearByDate(date: trip.checkInDate)
                                        
                                        for vacatioPoints in contract.vactionPointsYears.sorted() {
                                            if vacatioPoints.year == allotmentYear - 1 {
                                                vacatioPoints.points = vacatioPoints.points + trip.borrowedFromLastYear
                                            } else if vacatioPoints.year == allotmentYear {
                                                vacatioPoints.points = vacatioPoints.points + (Int(trip.points) - trip.borrowedFromLastYear - trip.borrowedFromNextYear)
                                            } else if vacatioPoints.year == allotmentYear + 1 {
                                                vacatioPoints.points = vacatioPoints.points + trip.borrowedFromNextYear
                                            }
                                        }
                                    }
                                    withAnimation() {
                                        modelContext.delete(trip)
                                    }
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            
        }
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(.white)
                .shadow(radius: 5)
        )
    }
}

//#Preview {
//    TripView()
//}
