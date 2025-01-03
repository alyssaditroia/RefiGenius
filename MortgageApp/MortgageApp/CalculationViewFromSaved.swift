//
//  CalculationViewFromSaved.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/26/24.
//
import SwiftUI

struct CalculationViewFromSaved: View {
    let loan: Loan

    var body: some View {
        VStack {
            CustomHeaderView(title: "Calculation Results", subtitle: "", bgColor: Color.blue)
            ScrollView {
                // Metrics Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Current Monthly Savings:").fontWeight(.bold)
                        Spacer()
                        Text("$\(String(format: "%.2f", loan.monthlySavings))")
                    }
                    HStack {
                        Text("Average Yearly Savings:").fontWeight(.bold)
                        Spacer()
                        Text("$\(String(format: "%.2f", loan.yearlySavings))")
                    }
                    HStack {
                        Text("Total Savings:").fontWeight(.bold)
                        Spacer()
                        Text("$\(String(format: "%.2f", loan.totalSavings))")
                    }
                }
                .padding(.horizontal)
                .font(.system(size: 16))
                
                Spacer()
                
                // Placeholder for bar chart and amortization schedule
                // ...
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .universalNavigation(currentView: "Calculator")
    }
}


