//
//  CalendarView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 04/06/2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var firstDayOfMonth = Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 1))!.startOfMonth
    @Binding var checkInDate: Date?
    @Binding var checkOutDate: Date?
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    @State private var nextMonthDays: [Date] = []
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        firstDayOfMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    Spacer()
                    
                    Text("\(firstDayOfMonth.formatted(Date.FormatStyle().month(.wide))) \(firstDayOfMonth.formatted(Date.FormatStyle().year(.defaultDigits)))")
                        .fontWeight(.black)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Button {
                        firstDayOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: firstDayOfMonth)!
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding(.bottom)
                
                HStack {
                    ForEach(daysOfWeek.indices, id: \.self) { index in
                        Text(daysOfWeek[index])
                            .fontWeight(.black)
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity)
                    }
                }
                LazyVGrid(columns: columns) {
                    ForEach(days, id: \.self) { day in
                        if day.monthInt != firstDayOfMonth.monthInt {
                            Text("")
                        } else {
                            Button {
                                withAnimation {
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
                                }
                            } label: {
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(checkInDate?.startOfDay == day.startOfDay || checkOutDate?.startOfDay == day.startOfDay
                                                     ? Color.secondaryBackground
                                                     : .primary)
                                    .frame(maxWidth: .infinity, minHeight: 35)
                                    .background(
                                        ZStack {
                                            if checkInDate != nil && checkOutDate != nil {
                                                if day == checkInDate {
                                                    Rectangle()
                                                        .foregroundStyle(Color.secondaryBackground)
                                                        .offset(x: 20)
                                                } else if day == checkOutDate {
                                                    Rectangle()
                                                        .foregroundStyle(Color.secondaryBackground)
                                                        .offset(x: -20)
                                                } else if day > checkInDate! && day < checkOutDate! {
                                                    Rectangle()
                                                        .foregroundStyle(Color.secondaryBackground)
                                                        .containerRelativeFrame(.horizontal) { size, axis in
                                                            size * 1/6
                                                        }
                                                }
                                            }
                                            Circle()
                                                .foregroundStyle(
                                                    checkInDate?.startOfDay == day.startOfDay || checkOutDate?.startOfDay == day.startOfDay
                                                    ? .accent
                                                    : .clear
                                                )
                                        }
                                    )
                            }
                        }
                    }
                }
                
                HStack {
                    Text("\(firstDayOfMonth.startOfNextMonth.formatted(Date.FormatStyle().month(.wide))) \(firstDayOfMonth.formatted(Date.FormatStyle().year(.defaultDigits)))")
                        .fontWeight(.black)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                
                LazyVGrid(columns: columns) {
                    ForEach(nextMonthDays, id: \.self) { day in
                        if day.monthInt != (firstDayOfMonth.monthInt + 1) {
                            Text("")
                        } else {
                            Button {
                                withAnimation {
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
                                }
                            } label: {
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(checkInDate?.startOfDay == day.startOfDay || checkOutDate?.startOfDay == day.startOfDay
                                                     ? Color.secondaryBackground
                                                     : .primary)
                                    .frame(maxWidth: .infinity, minHeight: 35)
                                    .background(
                                        ZStack {
                                            if checkInDate != nil && checkOutDate != nil {
                                                if day == checkInDate {
                                                    Rectangle()
                                                        .foregroundStyle(Color.secondaryBackground)
                                                        .offset(x: 20)
                                                } else if day == checkOutDate {
                                                    Rectangle()
                                                        .foregroundStyle(Color.secondaryBackground)
                                                        .offset(x: -20)
                                                } else if day > checkInDate! && day < checkOutDate! {
                                                    Rectangle()
                                                        .foregroundStyle(Color.secondaryBackground)
                                                        .containerRelativeFrame(.horizontal) { size, axis in
                                                            size * 1/6
                                                        }
                                                }
                                            }
                                            Circle()
                                                .foregroundStyle(
                                                    checkInDate?.startOfDay == day.startOfDay || checkOutDate?.startOfDay == day.startOfDay
                                                    ? .accent
                                                    : .clear
                                                )
                                        }
                                    )
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                days = firstDayOfMonth.calendarDisplayDays
                nextMonthDays = firstDayOfMonth.startOfNextMonth.calendarDisplayDays
            }
            .onChange(of: firstDayOfMonth) {
                days = firstDayOfMonth.calendarDisplayDays
                nextMonthDays = firstDayOfMonth.startOfNextMonth.calendarDisplayDays
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Trip Dates")
            .toolbar {
                ToolbarItem {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    
    struct Preview: View {
        @State var checkInDate: Date? = nil
        @State var checkOutDate: Date? = nil
        var body: some View {
            CalendarView(checkInDate: $checkInDate, checkOutDate: $checkOutDate)
        }
    }
    
    return Preview()
}
