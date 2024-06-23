//
//  Displayable+Protocol.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 22/06/2024.
//

import Foundation

protocol Displayable {
    func display() -> String
}

protocol HashableDisplayable: Displayable, Hashable, Comparable {
    
}
