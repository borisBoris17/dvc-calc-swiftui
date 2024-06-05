//
//  CalendarView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 04/06/2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var color: Color = .blue
    @State private var firstDayOfMonth = Date.now.startOfMonth
    @State private var checkInDate: Date? = nil
    @State private var checkOutDate: Date? = nil
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    var body: some View {
        VStack {
            LabeledContent("Calendar Color") {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            //            LabeledContent("Date/Time") {
            //                DatePicker("", selection: $checkInDate)
            //            }
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != firstDayOfMonth.monthInt {
                        Text("")
                    } else {
                        Button {
                            if checkInDate != nil {
                                if checkOutDate != nil {
                                    checkInDate = nil
                                    checkOutDate = nil
                                    return
                                } else {
                                    if day > checkInDate! {
                                        checkOutDate = day
                                    } else {
                                        checkInDate = nil
                                        checkOutDate = nil
                                    }
                                }
                            } else {
                                checkInDate = day
                            }
                        } label: {
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(
                                    ZStack {
                                        if checkInDate != nil && checkOutDate != nil {
                                            if day == checkInDate {
                                                Rectangle()
                                                    .foregroundStyle(.red)
                                                    .offset(x: 20)
                                            } else if day == checkOutDate {
                                                Rectangle()
                                                    .foregroundStyle(.red)
                                                    .offset(x: -20)
                                            } else if day > checkInDate! && day < checkOutDate! {
                                                Rectangle()
                                                    .foregroundStyle(.red)
                                                    .containerRelativeFrame(.horizontal) { size, axis in
                                                        size * 1/6
                                                    }
                                            }
                                        }
                                        Circle()
                                            .foregroundStyle(
                                                checkInDate?.startOfDay == day.startOfDay || checkOutDate?.startOfDay == day.startOfDay
                                                ? .purple
                                                : .clear
                                            )
                                    }
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            days = firstDayOfMonth.calendarDisplayDays
        }
        .onChange(of: firstDayOfMonth) {
            days = firstDayOfMonth.calendarDisplayDays
        }
    }
}

#Preview {
    CalendarView()
}
