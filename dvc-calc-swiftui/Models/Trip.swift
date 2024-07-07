//
//  Trip.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 03/07/2024.
//

import Foundation
import SwiftData

@Model
class Trip: Comparable {
    static func < (lhs: Trip, rhs: Trip) -> Bool {
        lhs.checkInDate < rhs.checkInDate
    }
    
    var id = UUID()
    var resortId: UUID
    var checkInDate: Date
    var checkOutDate: Date
    
    init(resortId: UUID, checkInDate: Date, checkOutDate: Date) {
        self.resortId = resortId
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
    }
}
