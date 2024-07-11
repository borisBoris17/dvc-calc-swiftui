//
//  Contract.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 06/07/2024.
//

import Foundation
import SwiftData

enum UseYear: String, Codable {
    case February = "February"
    case March = "March"
    case April = "April"
    case June = "June"
    case August = "August"
    case September = "September"
    case October = "October"
    case December = "December"
}

@Model
class Contract: Comparable {
    static func < (lhs: Contract, rhs: Contract) -> Bool {
        lhs.points < rhs.points
    }
    
    var id = UUID()
    var resortId: UUID
    var points: Int
    var useYear: UseYear
    var expirationYear: Int
    @Relationship(deleteRule: .cascade, inverse: \VacationPoints.contract) var vactionPointsYears: [VacationPoints] = []
    
    init(id: UUID = UUID(), resortId: UUID, points: Int, useYear: UseYear, expirationYear: Int) {
        self.id = id
        self.resortId = resortId
        self.points = points
        self.useYear = useYear
        self.expirationYear = expirationYear
    }
}
