//
//  Resort.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import Foundation
import SwiftData

@Model
class Resort: Identifiable, HashableDisplayable, Codable {
    
    enum CodingKeys: CodingKey {
        case id
        case resortName
        case shortName
        case expireYear
        case roomTypes
    }
    
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        lhs.resortName < rhs.resortName
    }
    
    static func > (lhs: Resort, rhs: Resort) -> Bool {
        lhs.resortName > rhs.resortName
    }
    
    func display() -> String {
        resortName
    }
    
    var id: UUID
    var resortName: String
    var shortName: String
    var expireYear: Int16
    var roomTypes: [RoomType]
    
    init(id: UUID, name: String, shortName: String, expireYear: Int16, roomTypes: [RoomType]) {
        self.id = id
        self.resortName = name
        self.shortName = shortName
        self.expireYear = expireYear
        self.roomTypes = roomTypes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.resortName = try container.decode(String.self, forKey: .resortName)
        self.shortName = try container.decode(String.self, forKey: .shortName)
        self.expireYear = try container.decode(Int16.self, forKey: .expireYear)
        self.roomTypes = try container.decode([RoomType].self, forKey: .roomTypes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(resortName, forKey: .resortName)
        try container.encode(shortName, forKey: .shortName)
        try container.encode(expireYear, forKey: .expireYear)
        try container.encode(roomTypes, forKey: .roomTypes)
    }
}
