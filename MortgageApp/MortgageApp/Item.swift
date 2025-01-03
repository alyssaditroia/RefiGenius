//
//  Item.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
