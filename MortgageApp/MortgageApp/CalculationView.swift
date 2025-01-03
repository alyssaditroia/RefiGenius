//
//  CalculationView.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/26/24.
//
import SwiftUI
import Charts
import SwiftData

struct CalculationView: View {
    @ObservedObject var loanViewModel: LoanViewModel
    @Environment(\.modelContext) private var modelContext
    @State private var entryName: String = ""
    
    var body: some View {
        VStack {
            CustomHeaderView(title: "Calculation Results", subtitle: "", bgColor: Color.blue)
            ScrollView {
                // Metrics Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Current Monthly Savings:").fontWeight(.bold)
                        Spacer()
                        Text("$\(String(format: "%.2f", loanViewModel.monthlySavings))")
                    }
                    HStack {
                        Text("Average Yearly Savings:").fontWeight(.bold)
                        Spacer()
                        Text("$\(String(format: "%.2f", loanViewModel.yearlySavings))")
                    }
                    HStack {
                        Text("Total Savings:").fontWeight(.bold)
                        Spacer()
                        Text("$\(String(format: "%.2f", loanViewModel.totalSavings))")
                    }
                }
                .padding(.horizontal)
                .font(.system(size: 16))
                
                Spacer()
                
                // Placeholder for bar chart and amortization schedule
                // ...

                Spacer()
                
                TextField("Entry Name", text: $entryName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    // Save calculation
                    guard !entryName.isEmpty else { return }
                    let loan = Loan(
                        currentLoanAmount: Double(loanViewModel.currentLoanAmount) ?? 0,
                        currentInterestRate: Double(loanViewModel.currentInterestRate) ?? 0,
                        currentTermYears: Int(loanViewModel.currentTermYears) ?? 0,
                        newLoanAmount: Double(loanViewModel.newLoanAmount) ?? 0,
                        newInterestRate: Double(loanViewModel.newInterestRate) ?? 0,
                        newTermYears: Int(loanViewModel.newTermYears) ?? 0,
                        closingCosts: 0, // Replace with actual data
                        monthlySavings: loanViewModel.monthlySavings,
                        yearlySavings: loanViewModel.yearlySavings,
                        totalSavings: loanViewModel.totalSavings
                    )
                    let result = SavedResult(name: entryName, date: Date(), type: .refinance)
                    loan.savedResult = result
                    result.loan = loan

                    modelContext.insert(loan)
                    modelContext.insert(result)

                    do {
                        try modelContext.save()
                    } catch {
                        print("Failed to save result: \(error)")
                    }
                })  {
                    Text("Save Calculation")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .universalNavigation(currentView: "Calculator")
    }
}
