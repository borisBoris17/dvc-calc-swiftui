//
//  RoomCategory.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 21/06/2024.
//

import Foundation

struct RoomCategory: Hashable, Comparable {
    var name: String
    var order: Int
    
    static func < (lhs: RoomCategory, rhs: RoomCategory) -> Bool {
        lhs.order < rhs.order
    }
}
