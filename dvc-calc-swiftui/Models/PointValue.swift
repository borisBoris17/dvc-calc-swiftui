//
//  PointValue.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import Foundation
import SwiftData

@Model
class PointValue {
    var id: UUID
    var startDate: Date
    var endDate: Date
    var weekdayRate: Int16
    var weekendRate: Int16
    var viewType: ViewType
    
    init(id: UUID, startDate: Date, endDate: Date, weekdayRate: Int16, weekendRate: Int16, viewType: ViewType) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.weekdayRate = weekdayRate
        self.weekendRate = weekendRate
        self.viewType = viewType
    }
}
