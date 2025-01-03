//
//  LoanViewModel.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftUI

class LoanViewModel: ObservableObject {
    // Current mortgage inputs
    @Published var currentLoanAmount: String = ""
    @Published var currentInterestRate: String = ""
    @Published var currentTermYears: String = ""

    // New mortgage inputs
    @Published var newLoanAmount: String = ""
    @Published var newInterestRate: String = ""
    @Published var newTermYears: String = ""

    // Calculated results
    @Published var monthlySavings: Double = 0.0
    @Published var yearlySavings: Double = 0.0
    @Published var totalSavings: Double = 0.0

    func calculateRefinance() {
        guard let currentLoanAmount = Double(currentLoanAmount),
              let currentInterestRate = Double(currentInterestRate),
              let currentTermYears = Int(currentTermYears),
              let newLoanAmount = Double(newLoanAmount),
              let newInterestRate = Double(newInterestRate),
              let newTermYears = Int(newTermYears) else {
            // Handle invalid inputs
            return
        }

        let currentMonthlyPayment = calculateMonthlyPayment(loanAmount: currentLoanAmount, interestRate: currentInterestRate, termYears: currentTermYears)
        let newMonthlyPayment = calculateMonthlyPayment(loanAmount: newLoanAmount, interestRate: newInterestRate, termYears: newTermYears)
        monthlySavings = currentMonthlyPayment - newMonthlyPayment
        yearlySavings = monthlySavings * 12
        totalSavings = yearlySavings * Double(newTermYears)
    }

    private func calculateMonthlyPayment(loanAmount: Double, interestRate: Double, termYears: Int) -> Double {
        let r = interestRate / 100 / 12
        let n = Double(termYears * 12)
        let payment = loanAmount * r / (1 - pow(1 + r, -n))
        return payment
    }
}



