//
//  ViewType.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import Foundation
import SwiftData

@Model
class ViewType: Comparable {
    static func < (lhs: ViewType, rhs: ViewType) -> Bool {
        lhs.order < rhs.order
    }
    
    var id: UUID
    var order: Int16
    var roomCapacity: Int16
    var viewName: String
    var pointValues: [PointValue]
    var roomType: RoomType
    
    init(id: UUID, order: Int16, roomCapacity: Int16, viewName: String, pointValues: [PointValue], roomType: RoomType) {
        self.id = id
        self.order = order
        self.roomCapacity = roomCapacity
        self.viewName = viewName
        self.pointValues = pointValues
        self.roomType = roomType
    }
}
