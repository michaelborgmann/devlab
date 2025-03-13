//
//  SwiftUI_Button_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI

struct SwiftUI_Button_Basic_DemoView: View {
    
    @State private var buttonText = "Tap me!"
    @State private var count = 0
    @State private var selectedStyle: ButtonStyleType = .automatic
    
    @Binding var showToast: Bool
    @Binding var toastMessage: String
    @Binding var subtitle: String?
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("A basic button that triggers an action.")
                .font(.headline)
            
            ButtonStyleType.selector(selectedStyle: $selectedStyle)
            
            Spacer()
            
            selectedStyle.style() {
                toastMessage = "Button Pressed"
                showToast = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showToast = false
                }
            }
            
            Spacer()
        }
        .onAppear {
            subtitle = "Basic Button"
        }
    }
}

#Preview {
    SwiftUI_Button_Basic_DemoView(showToast: .constant(true), toastMessage: .constant("Button Pressed Toast Message"), subtitle: .constant(nil))
}
