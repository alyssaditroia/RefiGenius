//
//  AppraisalEstimateView.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/26/24.
//
import SwiftUI
import MapKit
import SwiftData

struct AppraisalEstimateView: View {
    @ObservedObject var viewModel: AppraisalViewModel
    @Environment(\.modelContext) private var modelContext
    @State private var entryName: String = ""
    
    var body: some View {
        VStack {
            CustomHeaderView(title: "Appraisal Estimate", subtitle: "", bgColor: Color.blue)
            
            // Address display
            VStack(alignment: .leading) {
                Text(viewModel.address)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(nil)
                    .padding(.leading, 16)
                    .offset(y: -40)
            }
            
            // Estimated value display
            VStack(alignment: .leading) {
                Text("Estimated Value: $\(String(format: "%.2f", viewModel.estimatedValue))")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(nil)
                    .padding(.leading, 16)
                    .offset(y: -30)
            }
            
            // Map with current and comparable homes
            Map(
                coordinateRegion: $viewModel.region,
                annotationItems: viewModel.comparableHomes
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
            
            TextField("Entry Name", text: $entryName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                guard !entryName.isEmpty else { return }
                
                let appraisal = Appraisal(
                    address: viewModel.address,
                    estimatedValue: viewModel.estimatedValue,
                    date: Date()
                )
                
                // Add comparable homes
                for home in viewModel.comparableHomes {
                    let comparableHome = ComparableHome(
                        name: home.name,
                        value: home.value,
                        latitude: home.latitude,
                        longitude: home.longitude
                    )
                    comparableHome.appraisal = appraisal
                    appraisal.comparableHomes.append(comparableHome)
                    modelContext.insert(comparableHome)
                }
                
                let result = SavedResult(
                    name: entryName,
                    date: Date(),
                    type: .appraisal
                )
                appraisal.savedResult = result
                result.appraisal = appraisal
                
                modelContext.insert(appraisal)
                modelContext.insert(result)
                
                do {
                    try modelContext.save()
                } catch {
                    print("Failed to save appraisal: \(error)")
                }
            }) {
                Text("Save Estimate")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
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





