//
//  UseYear.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 20/07/2024.
//

import Foundation

enum UseYear: String, Codable {
    case February = "February"
    case March = "March"
    case April = "April"
    case June = "June"
    case August = "August"
    case September = "September"
    case October = "October"
    case December = "December"
    
    var monthNumber: Int {
        switch self {
        case .February:
            return 2
        case .March:
            return 3
        case .April:
            return 4
        case .June:
            return 6
        case .August:
            return 8
        case .September:
            return 9
        case .October:
            return 10
        case .December:
            return 12
        }
    }
    
    var pointAllotmentYear: Int {
        var currentMonth = Calendar.current.component(.month, from: Date())
        var currentYear = Calendar.current.component(.year, from: Date())
        if currentMonth < self.monthNumber { currentYear -= 1}
        return currentYear
    }
}

