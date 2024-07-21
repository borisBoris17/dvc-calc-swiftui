//
//  RoomType.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import Foundation
import SwiftData

@Model
class RoomType: Comparable, Codable {
    
    enum CodingKeys: CodingKey {
        case id
        case order
        case roomName
        case roomCategory
        case viewTypes
        case resortId
    }
    
    static func < (lhs: RoomType, rhs: RoomType) -> Bool {
        lhs.order < rhs.order
    }
    
    var id: UUID
    var order: Int16
    var roomName: String
    var roomCategory: String
    var viewTypes: [ViewType]
    var resortId: UUID
    
    init(id: UUID, order: Int16, name: String, cetegory: String, viewTypes: [ViewType], resortId: UUID) {
        self.id = id
        self.order = order
        self.roomName = name
        self.roomCategory = cetegory
        self.viewTypes = viewTypes
        self.resortId = resortId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.order = try container.decode(Int16.self, forKey: .order)
        self.roomName = try container.decode(String.self, forKey: .roomName)
        self.roomCategory = try container.decode(String.self, forKey: .roomCategory)
        self.viewTypes = try container.decode([ViewType].self, forKey: .viewTypes)
        self.resortId = try container.decode(UUID.self, forKey: .resortId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(order, forKey: .order)
        try container.encode(roomName, forKey: .roomName)
        try container.encode(roomCategory, forKey: .roomCategory)
        try container.encode(viewTypes, forKey: .viewTypes)
        try container.encode(resortId, forKey: .resortId)
    }
}
