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
    
    @Query private var resorts: [Resort]
    @Query private var roomTypes: [RoomType]
    @Query private var viewTypes: [ViewType]
    
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
    
    var body: some View {
        HStack {
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
                    
                    Text("365 Days")
                }
                
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
                }
            }
            .padding()
            
            Spacer()
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
