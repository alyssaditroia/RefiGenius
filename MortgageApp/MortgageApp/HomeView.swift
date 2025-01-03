//
//  HomeView.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            // Title
            CustomHeaderView(title: "ReƒiGenius", subtitle: "", bgColor: Color.blue)
            Image(systemName: "brain.filled.head.profile")
                .foregroundStyle(Color.blue)
                .font(.system(size: 130))
                .padding()
            // Buttons for the main options
            NavigationLink(destination: RefinanceCalculatorView()) {
                Text("Mortgage Refinance Calculator")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            NavigationLink(destination: AppraisalEstimatorView()) {
                Text("Appraisal Estimator")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            NavigationLink(destination: SavedResultsView()) {
                Text("Saved Results")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
