//
//  SavedResultViewModel.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/26/24.
//
import SwiftUI
import SwiftData

class SavedResultsViewModel: ObservableObject {
    @Published var savedResults: [SavedResult] = []

    func loadSavedResults() {
        // Load from SwiftData
        // For now, we'll use dummy data
        // In a real application, load from persistent storage
        savedResults = [] // TODO: Load from SwiftData
    }

    func saveResult(_ result: SavedResult) {
        // Save to SwiftData
        savedResults.append(result)
        // Persist the data
        // TODO: Save to SwiftData
    }
}


