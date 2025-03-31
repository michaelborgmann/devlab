//
//  SwiftUI_TextField_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/03/2025.
//

import SwiftUI

struct SwiftUI_TextField_Basic_DemoView: DemoPage {
    
    @State private var selectedStyle: SwiftUI_TextFieldStyleType = .automatic
    @State private var inputText: String = ""
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("A basic text field to input text.")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            SwiftUI_TextFieldStyleType.selector(selectedStyle: $selectedStyle)
                .accessibilityLabel("Select a Text Field Style")
                .accessibilityHint("Tap to choose a text field style.")
            
            selectedStyle.style(text: $inputText)
                .accessibilityLabel("Text Field")
                .accessibilityValue(inputText)
                .accessibilityHint("Tap to edit text.")
            
            Text("Current text: \(inputText)")
                .font(.subheadline)
                .foregroundColor(.blue)
                .accessibilityLabel("Current text entered is \(inputText)")
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.subtitle = "Basic TextField"
        }
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    SwiftUI_TextField_Basic_DemoView(viewModel: $viewModel)
}
