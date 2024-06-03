//
//  ContentView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 16/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var resorts: [Resort]
    @Query var pointValues: [PointValue]
    
    var body: some View {
        ScrollView {
            Image("dvcCalc")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            ForEach(resorts) { resort in
                VStack {
                    Text("\(resort.resortName) - \(resort.id)")
                    
                    ForEach(resort.roomTypes) { roomType in
                        Text("\(roomType.roomName) - \(roomType.id)")
                    }
                }
                Spacer()
            }
        
            ForEach(pointValues) { pointValue in
                VStack {
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

@Model
class Resort {
    var id: UUID
    var resortName: String
    var roomTypes: [RoomType]

    init(id: UUID, name: String, roomTypes: [RoomType]) {
        self.id = id
        self.resortName = name
        self.roomTypes = roomTypes
    }
}

@Model
class RoomType {
    var id: UUID
    var roomName: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.roomName = name
    }
}

@Model
class PointValue {
    // TODO: Add back when the new data is ready
//    var id: UUID
    var startDate: Date
    var endDate: Date
    var weekdayRate: Int16
    var weekendRate: Int16
    
    init(id: UUID, startDate: Date, endDate: Date, weekdayRate: Int16, weekendRate: Int16) {
//        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.weekdayRate = weekdayRate
        self.weekendRate = weekendRate
    }
}

#Preview {
    ContentView()
}
