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
    var roomTypeId: UUID
    var viewTypeId: UUID
    var checkInDate: Date
    var checkOutDate: Date
    var points: Int
    var borrowedFromLastYear: Int
    var borrowedFromNextYear: Int
    var contract: Contract? = nil
    
    init(resortId: UUID, roomTypeId: UUID, viewTypeId: UUID, checkInDate: Date, checkOutDate: Date, points: Int, borrowedFromLastYear: Int, borrowedFromNextYear: Int, contract: Contract?) {
        self.resortId = resortId
        self.roomTypeId = roomTypeId
        self.viewTypeId = viewTypeId
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.points = points
        self.borrowedFromLastYear = borrowedFromLastYear
        self.borrowedFromNextYear = borrowedFromNextYear
        self.contract = contract
    }
}
