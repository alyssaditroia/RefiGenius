//
//  Appraisal.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftData
import Foundation
import CoreLocation

@Model
class Appraisal: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var address: String
    var estimatedValue: Double
    var date: Date

    @Relationship(deleteRule: .cascade, inverse: \ComparableHome.appraisal)
    var comparableHomes: [ComparableHome] = []

    @Relationship(deleteRule: .nullify, inverse: \SavedResult.appraisal)
    var savedResult: SavedResult?

    init(address: String, estimatedValue: Double, date: Date = Date()) {
        self.address = address
        self.estimatedValue = estimatedValue
        self.date = date
    }
}

@Model
class ComparableHome: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var value: String
    var latitude: Double
    var longitude: Double

    @Relationship(deleteRule: .nullify, inverse: \Appraisal.comparableHomes)
    var appraisal: Appraisal?

    init(name: String, value: String, latitude: Double, longitude: Double) {
        self.name = name
        self.value = value
        self.latitude = latitude
        self.longitude = longitude
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}





