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
    
    @State var checkInDate = Date()
    @State var checkOutDate =  Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    
    var body: some View {
        VStack {
            Image("logo")
            
            HStack {
                DatePicker("Check In Date", selection: $checkInDate, displayedComponents: [.date])
                DatePicker("Check Out Date", selection: $checkOutDate, displayedComponents: [.date])
            }
            .labelsHidden()
            
            
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
        }
//        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("BackgroundColor"))
    }
}

#Preview {
    CalculatorView()
}
