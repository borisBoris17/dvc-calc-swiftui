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
    
    @Query private var resorts: [Resort] = []
    
    init(trip: Trip) {
        self.trip = trip
        let resortId = trip.resortId
        
        self._resorts = Query(filter: #Predicate<Resort> {
            $0.id == resortId
        }, sort: \.resortName)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(resorts[0].resortName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("\(resorts[0].id)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                // TODO: save the view and room type on trip fetch the viewtype from the id then add here.
                
                HStack {
                    Text("\(trip.checkInDate.formatted(date: .long, time: .omitted)) - \(trip.checkOutDate.formatted(date: .long, time: .omitted))")
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
