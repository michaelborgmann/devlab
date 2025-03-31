//
//  SwiftUI_Slider_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/03/2025.
//

import SwiftUI

struct SwiftUI_Slider_Basic_DemoView: DemoPage {

    @State private var value: Double = 50
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("A basic slider that adjusts a value.")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            Slider(value: $value, in: 0...100, step: 1)
                .onChange(of: value) { _, newValue in
                    viewModel.subtitle = "Slider Value: \(Int(newValue))"
                }
                .accessibilityLabel("Adjustable Value")
                .accessibilityValue(Text("\(Int(value))"))
                .accessibilityHint("Swipe up to increase, down to decrease in increments of 1.")
            
            Text("Current value: \(Int(value))")
                .font(.subheadline)
                .foregroundColor(.blue)
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.subtitle = "Basic Slider"
        }
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    SwiftUI_Slider_Basic_DemoView(viewModel: $viewModel)
}
