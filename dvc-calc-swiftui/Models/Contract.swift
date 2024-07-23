//
//  Contract.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 06/07/2024.
//

import Foundation
import SwiftData

@Model
class Contract: Comparable {
    static func < (lhs: Contract, rhs: Contract) -> Bool {
        lhs.points < rhs.points
    }
    
    var id = UUID()
    var resortId: UUID
    var points: Int
    var useYear: UseYear
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \VacationPoints.contract) var vactionPointsYears: [VacationPoints] = []
    
    init(id: UUID = UUID(), resortId: UUID, points: Int, useYear: UseYear, name: String) {
        self.id = id
        self.resortId = resortId
        self.points = points
        self.useYear = useYear
        self.name = name
    }
}
