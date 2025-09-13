//
//  SwiftUI_NavigationStack_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 13/09/2025.
//

import SwiftUI

struct SwiftUI_NavigationStack_Basic_DemoView: DemoPage {
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var body: some View {
        
        NavigationStack {
            List(1..<6, id: \.self) { number in
                NavigationLink("Go to Detail \(number)") {
                    detail(number)
                }
            }
            .navigationTitle("Basic NavigationStack")
        }
        .onAppear { viewModel.subtitle = "NavigationStack Basics" }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("NavigationStack Basic Demo. Select a row to navigate to its detail view.")
        .accessibilityHint("Tap on a row in the list to see a detail screen.")
    }

    @ViewBuilder
    private func detail(_ number: Int) -> some View {
        VStack(spacing: 20) {
            Text("Detail View \(number)").font(.title)
            Text("You navigated here from the list.")
                .font(.body).foregroundStyle(.secondary)
        }
        .onAppear { viewModel.subtitle = "Detail \(number)" }
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    
    
        SwiftUI_NavigationStack_Basic_DemoView(viewModel: $viewModel)
    
}
