//
//  TripsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import SwiftUI
import SwiftData

struct TripsView: View {
    @Query var trips: [Trip]
    
    var body: some View {
        VStack {
            Text("Trips")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.font)
            
            ScrollView {
                ForEach(trips) { trip in
                    TripView(trip: trip)
                        .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
    }
}

#Preview {
    TripsView()
}
