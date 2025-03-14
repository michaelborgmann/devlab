//
//  SwiftUI_Button_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI

struct SwiftUI_Button_Basic_DemoView: View {
    
    @State private var selectedStyle: ButtonStyleType = .automatic
    
    @Binding var showToast: Bool
    @Binding var toastMessage: String
    @Binding var subtitle: String?
    
    var body: some View {
        VStack(spacing: 30) {

            Text("A basic button that triggers an action.")
                .font(.headline)
                .accessibilityLabel("A basic button that triggers an action.")
                .accessibilityHint("Choose a button style from the list below.")
            
            ButtonStyleType.selector(selectedStyle: $selectedStyle)
            
            Spacer()
            
            selectedStyle.style(showToastMessage)
            
            Spacer()
        }
        .onAppear {
            subtitle = "Basic Button"
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Basic Button Demo. Select a button style and trigger an action.")
        .accessibilityHint("Select a style to see a corresponding button in action.")
    }
    
    private func showToastMessage() {
        
        toastMessage = "Button Pressed"
        showToast = true
        
        Task {
            try? await Task.sleep(for: .seconds(1))
            showToast = false
        }
    }
}

#Preview {
    @Previewable @State var showToast = false
    @Previewable @State var toastMessage = ""
    
    VStack {
        SwiftUI_Button_Basic_DemoView(showToast: $showToast, toastMessage: $toastMessage, subtitle: .constant(nil))
    }
    .overlay {
        Text(toastMessage)
            .toast(showToast: $showToast, toastMessage: $toastMessage)
    }
    .animation(.easeInOut, value: showToast)
}
