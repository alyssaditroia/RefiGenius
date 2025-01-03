//
//  AppraisalEstimateViewFromSaved.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/26/24.
//
import SwiftUI
import MapKit

struct AppraisalEstimateViewFromSaved: View {
    let appraisal: Appraisal

    @State private var region: MKCoordinateRegion

    init(appraisal: Appraisal) {
        self.appraisal = appraisal
        let coordinate = appraisal.comparableHomes.first?.coordinate ?? CLLocationCoordinate2D()
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    var body: some View {
        VStack {
            CustomHeaderView(title: "Appraisal Estimate", subtitle: "", bgColor: Color.blue)
            
            // Address display
            VStack(alignment: .leading) {
                Text(appraisal.address)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(nil)
                    .padding(.leading, 16)
                    .offset(y: -40)
            }
            
            // Estimated value display
            VStack(alignment: .leading) {
                Text("Estimated Value: $\(String(format: "%.2f", appraisal.estimatedValue))")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(nil)
                    .padding(.leading, 16)
                    .offset(y: -30)
            }
            
            // Map with current and comparable homes
            Map(
                coordinateRegion: $region,
                annotationItems: appraisal.comparableHomes
            ) { home in
                MapAnnotation(coordinate: home.coordinate) {
                    VStack {
                        textBubble(for: home)
                        Image(systemName: "house.fill")
                            .foregroundColor(home.name == "Current Home" ? .blue : .red)
                            .font(.title2)
                    }
                }
            }
            .frame(height: 400)
            .cornerRadius(10)
            .padding()
            .offset(y: -20)
            
            Spacer()
        }
        .universalNavigation(currentView: "Appraisal")
        .navigationBarBackButtonHidden(true)
    }
    
    // Helper method to create the text bubble for the annotations
    private func textBubble(for home: ComparableHome) -> some View {
        VStack(alignment: .center) {
            Text(home.name)
                .font(.caption)
                .fontWeight(.bold)
                .padding(.horizontal, 6)
            Text(home.value)
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.horizontal, 6)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

