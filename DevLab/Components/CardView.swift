//
//  TechnologyCardView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI

struct CardView: View {
    let title: String
    let background: AnyView

    var body: some View {
        Text(title)
            .foregroundStyle(.white)
            .font(.title2)
            .bold()
            .frame(width: 200, height: 120)
            .background(
                background
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            )
            .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 3)
            .accessibilityLabel(title)
            .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    CardView(title: "Title is all what I want", background: AnyView(
        LinearGradient(
            gradient: Gradient(colors: [.purple, .blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    ))
}
