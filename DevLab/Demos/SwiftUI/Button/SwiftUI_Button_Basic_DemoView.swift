//
//  SwiftUI_Button_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI

struct SwiftUI_Button_Basic_DemoView: DemoPage {
    
    @State private var selectedStyle: SwiftUI_ButtonStyleType = .automatic
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var body: some View {
        VStack(spacing: 30) {

            Text("A basic button that triggers an action.")
                .font(.headline)
                .accessibilityLabel("A basic button that triggers an action.")
                .accessibilityHint("Choose a button style from the list below.")
            
            SwiftUI_ButtonStyleType.selector(selectedStyle: $selectedStyle)
            
            Spacer()
            
            selectedStyle.style(showToastMessage)
            
            Spacer()
        }
        .onAppear {
            viewModel.subtitle = "Basic Button"
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Basic Button Demo. Select a button style and trigger an action.")
        .accessibilityHint("Select a style to see a corresponding button in action.")
    }
    
    private func showToastMessage() {
        
        viewModel.toastMessage = "Button Pressed"
        viewModel.showToast = true
        
        Task {
            try? await Task.sleep(for: .seconds(1))
            viewModel.showToast = false
        }
    }
}

#Preview {

    @Previewable @State var viewModel = DemoViewModel()
    
    VStack {
        SwiftUI_Button_Basic_DemoView(viewModel: $viewModel)
    }
    .overlay {
        Text(viewModel.toastMessage)
            .toast(showToast: $viewModel.showToast, toastMessage: $viewModel.toastMessage)
    }
    .animation(.easeInOut, value: viewModel.showToast)
}
