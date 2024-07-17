//
//  Resort.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import Foundation
import SwiftData

@Model
class Resort: Identifiable, HashableDisplayable {
    
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
    var expireYear: Int16
    var roomTypes: [RoomType]

    init(id: UUID, name: String, expireYear: Int16, roomTypes: [RoomType]) {
        self.id = id
        self.resortName = name
        self.expireYear = expireYear
        self.roomTypes = roomTypes
    }
}
