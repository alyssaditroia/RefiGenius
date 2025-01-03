//
//  RefinanceCalculatorView.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftUI

struct RefinanceCalculatorView: View {
    @StateObject private var viewModel = LoanViewModel()
    @State private var navigateToCalculation = false
    
    var body: some View {
        VStack {
            CustomHeaderView(title:"Reƒinance Calculator", subtitle: "", bgColor: Color.blue)
            Form {
                Section(header: Text("Current Mortgage")) {
                    TextField("Loan Amount", text: $viewModel.currentLoanAmount)
                        .keyboardType(.decimalPad)
                    TextField("Interest Rate", text: $viewModel.currentInterestRate)
                        .keyboardType(.decimalPad)
                    TextField("Term (Years)", text: $viewModel.currentTermYears)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("New Mortgage")) {
                    TextField("Loan Amount", text: $viewModel.newLoanAmount)
                        .keyboardType(.decimalPad)
                    TextField("Interest Rate", text: $viewModel.newInterestRate)
                        .keyboardType(.decimalPad)
                    TextField("Term (Years)", text: $viewModel.newTermYears)
                        .keyboardType(.numberPad)
                }
                Section{
                    Button(action: {
                        viewModel.calculateRefinance()
                        navigateToCalculation = true
                    }) {
                        Text("Calculate")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                    .disabled(viewModel.currentLoanAmount.isEmpty || viewModel.currentInterestRate.isEmpty || viewModel.currentTermYears.isEmpty || viewModel.newLoanAmount.isEmpty || viewModel.newInterestRate.isEmpty || viewModel.newTermYears.isEmpty)
                }
            }
            .padding(.top, -68)
            .scrollContentBackground(.hidden)
            NavigationLink(destination: CalculationView(loanViewModel: viewModel), isActive: $navigateToCalculation) {
                EmptyView()
            }
        }
        .universalNavigation(currentView: "Calculator")
        .navigationBarBackButtonHidden(true)
    }
}
