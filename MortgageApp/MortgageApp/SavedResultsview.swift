//
//  SavedResultsview.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftUI
import SwiftData

struct SavedResultsView: View {
    @State private var searchText: String = ""
    @Query(sort: \SavedResult.date, order: .reverse) private var savedResults: [SavedResult]
    
    var filteredResults: [SavedResult] {
        if searchText.isEmpty {
            return savedResults
        } else {
            return savedResults.filter { result in
                result.name.lowercased().contains(searchText.lowercased()) ||
                result.type.rawValue.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            CustomHeaderView(title: "Saved Results", subtitle: "", bgColor: Color.blue)
            
            // Search bar
            TextField("Search...", text: $searchText)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            List {
                // Locked header row
                HStack {
                    Text("Name")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Date")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Type")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // List of filtered results
                ForEach(filteredResults, id: \.id) { result in
                    NavigationLink(destination: detailView(for: result)) {
                        HStack {
                            Text(result.name)  // Name
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(result.date, style: .date)  // Date
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(result.type.rawValue)  // Type
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        .universalNavigation(currentView: "Saved")
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private func detailView(for result: SavedResult) -> some View {
        if result.type == .appraisal, let appraisal = result.appraisal {
            AppraisalEstimateViewFromSaved(appraisal: appraisal)
        } else if result.type == .refinance, let loan = result.loan {
            CalculationViewFromSaved(loan: loan)
        } else {
            Text("Data not available")
        }
    }
}


