//
//  MortgageAppApp.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftUI
import SwiftData

@main
struct RefiGeniusApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
        }
        .modelContainer(for: [SavedResult.self, Loan.self, Appraisal.self, ComparableHome.self])
    }
}

