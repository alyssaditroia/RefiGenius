//
//  SavedResult.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/26/24.
//
import SwiftData
import Foundation

@Model
class SavedResult {
    @Field var id: UUID = UUID()
    var name: String
    var date: Date
    var type: ResultType

    // Use optional relationships without inverses to avoid circular references
    @Field var appraisal: Appraisal?
    @Field var loan: Loan?

    init(name: String, date: Date, type: ResultType, appraisal: Appraisal? = nil, loan: Loan? = nil) {
        self.name = name
        self.date = date
        self.type = type
        self.appraisal = appraisal
        self.loan = loan
    }
}

enum ResultType: String, Codable {
    case appraisal = "Appraisal"
    case refinance = "Refinance"
}

