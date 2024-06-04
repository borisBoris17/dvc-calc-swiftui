//
//  Resort.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/06/2024.
//

import Foundation
import SwiftData

@Model
class Resort {
    var id: UUID
    var resortName: String
    var roomTypes: [RoomType]

    init(id: UUID, name: String, roomTypes: [RoomType]) {
        self.id = id
        self.resortName = name
        self.roomTypes = roomTypes
    }
}
