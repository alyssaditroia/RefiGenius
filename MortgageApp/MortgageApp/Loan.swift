//
//  Loan.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftData
import Foundation

@Model
class Loan: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var currentLoanAmount: Double
    var currentInterestRate: Double
    var currentTermYears: Int
    var newLoanAmount: Double
    var newInterestRate: Double
    var newTermYears: Int
    var closingCosts: Double
    var monthlySavings: Double
    var yearlySavings: Double
    var totalSavings: Double
    var date: Date

    @Relationship(deleteRule: .nullify, inverse: \SavedResult.loan)
    var savedResult: SavedResult?

    init(currentLoanAmount: Double, currentInterestRate: Double, currentTermYears: Int, newLoanAmount: Double, newInterestRate: Double, newTermYears: Int, closingCosts: Double, monthlySavings: Double, yearlySavings: Double, totalSavings: Double, date: Date = Date()) {
        self.currentLoanAmount = currentLoanAmount
        self.currentInterestRate = currentInterestRate
        self.currentTermYears = currentTermYears
        self.newLoanAmount = newLoanAmount
        self.newInterestRate = newInterestRate
        self.newTermYears = newTermYears
        self.closingCosts = closingCosts
        self.monthlySavings = monthlySavings
        self.yearlySavings = yearlySavings
        self.totalSavings = totalSavings
        self.date = date
    }
}
