//
//  PointValue.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import Foundation
import SwiftData

@Model
class PointValue: Codable {
    
    enum CodingKeys: CodingKey {
        case id
        case startDate
        case endDate
        case weekdayRate
        case weekendRate
        case viewTypeId
    }
    
    var id: UUID
    var startDate: Date
    var endDate: Date
    var weekdayRate: Int16
    var weekendRate: Int16
    var viewTypeId: UUID
    
    init(id: UUID, startDate: Date, endDate: Date, weekdayRate: Int16, weekendRate: Int16, viewTypeId: UUID) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.weekdayRate = weekdayRate
        self.weekendRate = weekendRate
        self.viewTypeId = viewTypeId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        self.weekdayRate = try container.decode(Int16.self, forKey: .weekdayRate)
        self.weekendRate = try container.decode(Int16.self, forKey: .weekendRate)
        self.viewTypeId = try container.decode(UUID.self, forKey: .viewTypeId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(weekdayRate, forKey: .weekdayRate)
        try container.encode(weekendRate, forKey: .weekendRate)
        try container.encode(viewTypeId, forKey: .viewTypeId)
    }
}
