//
//  SwiftUI_Picker_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/03/2025.
//

import SwiftUI

struct SwiftUI_Picker_Basic_DemoView: DemoPage {
    
    @State private var selectedStyle: SwiftUI_PickerStyleType = .automatic
    @State private var selectedOption: Int = 0
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    let options = ["Option 1", "Option 2", "Option 3"]
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("A basic picker that selects an option.")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            SwiftUI_PickerStyleType.selector(selectedStyle: $selectedStyle, options: options)
                .accessibilityLabel("Select a Picker Style")
                .accessibilityHint("Tap to choose a picker style.")
            
            selectedStyle.style(selection: $selectedOption, options: options)
                .accessibilityLabel("Option Picker")
                .accessibilityValue(options[selectedOption])
                .accessibilityHint("Swipe or tap to select an option from the list.")
            
            Text("Current selection: \(options[selectedOption])")
                .font(.subheadline)
                .foregroundColor(.blue)
                .accessibilityLabel("Currently selected option is \(options[selectedOption])")
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.subtitle = "Basic Picker"
        }
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    SwiftUI_Picker_Basic_DemoView(viewModel: $viewModel)
}
