//
//  RoomType.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import Foundation
import SwiftData

@Model
class RoomType: Comparable {
    static func < (lhs: RoomType, rhs: RoomType) -> Bool {
        lhs.order < rhs.order
    }
    
    var id: UUID
    var order: Int16
    var roomName: String
    var roomCategory: String
    var viewTypes: [ViewType]
    var resort: Resort
    
    init(id: UUID, order: Int16, name: String, cetegory: String, viewTypes: [ViewType], resort: Resort) {
        self.id = id
        self.order = order
        self.roomName = name
        self.roomCategory = cetegory
        self.viewTypes = viewTypes
        self.resort = resort
    }
}
