//
//  ViewType.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import Foundation
import SwiftData

@Model
class ViewType: Comparable, Codable {
    
    enum CodingKeys: CodingKey {
        case id
        case order
        case roomCapacity
        case viewName
        case pointValues
        case roomTypeId
    }
    
    static func < (lhs: ViewType, rhs: ViewType) -> Bool {
        lhs.order < rhs.order
    }
    
    var id: UUID
    var order: Int16
    var roomCapacity: Int16
    var viewName: String
    var pointValues: [PointValue]
    var roomTypeId: UUID
    
    init(id: UUID, order: Int16, roomCapacity: Int16, viewName: String, pointValues: [PointValue], roomTypeId: UUID) {
        self.id = id
        self.order = order
        self.roomCapacity = roomCapacity
        self.viewName = viewName
        self.pointValues = pointValues
        self.roomTypeId = roomTypeId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.order = try container.decode(Int16.self, forKey: .order)
        self.roomCapacity = try container.decode(Int16.self, forKey: .roomCapacity)
        self.viewName = try container.decode(String.self, forKey: .viewName)
        self.pointValues = try container.decode([PointValue].self, forKey: .pointValues)
        self.roomTypeId = try container.decode(UUID.self, forKey: .roomTypeId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(order, forKey: .order)
        try container.encode(roomCapacity, forKey: .roomCapacity)
        try container.encode(viewName, forKey: .viewName)
        try container.encode(pointValues, forKey: .pointValues)
        try container.encode(roomTypeId, forKey: .roomTypeId)
    }
}
