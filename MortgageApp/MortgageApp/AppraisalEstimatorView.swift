//
//  AppraisalEstimatorView.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
import SwiftUI
import MapKit

struct AppraisalEstimatorView: View {
    @StateObject private var viewModel = AppraisalViewModel()
    @State private var inputAddress: String = ""
    @State private var navigateToEstimate = false
    
    var body: some View {
        VStack {
            CustomHeaderView(title:"Appraisal Estimator", subtitle: "", bgColor: Color.blue)
            
            TextField("Enter Address", text: $inputAddress)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Estimate Value Using Address") {
                if !inputAddress.isEmpty {
                    viewModel.appraiseUsingAddress(inputAddress)
                    navigateToEstimate = true
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            Button("Estimate Value Using Current Location") {
                viewModel.appraiseUsingCurrentLocation()
                navigateToEstimate = true
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .frame(height: 300)
                .cornerRadius(10)
                .padding()

            Spacer()
        }
        .universalNavigation(currentView: "Appraisal")
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToEstimate) {
            AppraisalEstimateView(viewModel: viewModel)
        }
    }
}





