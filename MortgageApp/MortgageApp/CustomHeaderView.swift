//
//  CustomHeaderView.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftUI
import Foundation
struct CustomHeaderView: View {
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    var bgColor: Color
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var isLandscape: Bool {
        horizontalSizeClass == .compact && verticalSizeClass == .regular
    }
    
    var body: some View {
        ZStack {
            // Background ellipse for iPad and iPhone
            Ellipse()
                .fill(bgColor)
                .frame(width: UIScreen.main.bounds.width * 1.4,
                       height: isLandscape ? UIScreen.main.bounds.height * 0.19 : UIScreen.main.bounds.height * 0.15)
                .position(x: UIScreen.main.bounds.width / 2.35,
                          y: UIScreen.main.bounds.height * 0.05)
                .clipShape(Rectangle())
                .shadow(radius: 3)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.04)
                .padding(.top, UIScreen.main.bounds.height * 0.06)
                Spacer()
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.15)
        .edgesIgnoringSafeArea(.all)
    }
}

