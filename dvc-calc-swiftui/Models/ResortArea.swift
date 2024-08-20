//
//  ResortArea.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 17/08/2024.
//

import Foundation
import SwiftData

@Model
class ResortArea: Identifiable, HashableDisplayable, Codable {
    
    enum CodingKeys: CodingKey {
        case resortArea
        case order
        case resorts
    }
    
    static func < (lhs: ResortArea, rhs: ResortArea) -> Bool {
        lhs.order < rhs.order
    }
    
    static func > (lhs: ResortArea, rhs: ResortArea) -> Bool {
        lhs.order > rhs.order
    }
    
    func display() -> String {
        resortArea
    }
    
    var id: UUID = UUID()
    var resortArea: String
    var order: Int16
    var resorts: [Resort]
    
    init(resortArea: String, order: Int16, resorts: [Resort]) {
        self.resortArea = resortArea
        self.order = order
        self.resorts = resorts
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        resortArea = try container.decode(String.self, forKey: .resortArea)
        order = try container.decode(Int16.self, forKey: .order)
        resorts = try container.decode([Resort].self, forKey: .resorts)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(resortArea, forKey: .resortArea)
        try container.encode(order, forKey: .order)
        try container.encode(resorts, forKey: .resorts)
    }
}
