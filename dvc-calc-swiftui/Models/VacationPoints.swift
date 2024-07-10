//
//  VacationPoints.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 08/07/2024.
//

import Foundation
import SwiftData

@Model
class VacationPoints: Comparable {
    
    var id: UUID = UUID()
    var year: Int
    @Relationship var contract: Contract
    var points: Int
    
    init(year: Int, contract: Contract, points: Int) {
        self.year = year
        self.contract = contract
        self.points = points
    }
    
    static func < (lhs: VacationPoints, rhs: VacationPoints) -> Bool {
        lhs.year < rhs.year
    }
}
