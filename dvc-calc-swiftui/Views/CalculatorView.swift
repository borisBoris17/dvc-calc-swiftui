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
    @Query(filter: #Predicate<PointValue> { pointValue in
        pointValue.viewType.roomType.roomName == "Tower Studio"
    }) var pointValues: [PointValue]
    
    var body: some View {
        ScrollView {
            Image("dvcCalc")
                .imageScale(.large)
            
            ForEach(resorts) { resort in
                VStack {
                    Text("\(resort.resortName)")
                    
                    ForEach(resort.roomTypes.sorted()) { roomType in
                        Text("\(roomType.roomName)")
                        ForEach(roomType.viewTypes.sorted()) { viewType in
                            Text(viewType.viewName)
                        }
                    }
                }
                Spacer()
            }
        
            ForEach(pointValues) { pointValue in
                VStack {
                    Text(pointValue.viewType.roomType.roomName)
                    HStack {
                        Text(pointValue.startDate, format: .dateTime.month().day())
                        Text(" - ")
                        Text(pointValue.endDate, format: .dateTime.month().day())
                    }
                    
                    Text("Weekday Rate: \(pointValue.weekdayRate)")
                    Text("Weekend Rate: \(pointValue.weekendRate)")
                }
            }
        }
        .padding()
    }
}

#Preview {
    CalculatorView()
}
