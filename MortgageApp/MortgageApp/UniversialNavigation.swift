//
//  UniversialNavigation.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftUI

struct UniversalNavigationBar: ViewModifier {
    var currentView: String

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        if currentView != "Home" {
                            NavigationLink(destination: HomeView()) {
                                Text("Home")
                            }
                        }
                        if currentView != "Calculator" {
                            NavigationLink(destination: RefinanceCalculatorView()) {
                                Text("Calculator")
                            }
                        }
                        if currentView != "Appraisal" {
                            NavigationLink(destination: AppraisalEstimatorView()) {
                                Text("Appraisal")
                            }
                        }
                        if currentView != "Saved" {
                            NavigationLink(destination: SavedResultsView()) {
                                Text("Saved")
                            }
                        }
                    }
                }
            }
    }
}

extension View {
    func universalNavigation(currentView: String) -> some View {
        self.modifier(UniversalNavigationBar(currentView: currentView))
    }
}
