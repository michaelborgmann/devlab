//
//  SwiftUI_Button_Animation_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 17/03/2025.
//

import SwiftUI

struct SwiftUI_Button_Animation_DemoView: View {
    
    @Binding var subtitle: String?
    
    @State private var isScaling = false
    @State private var isRotating = false
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            Text("Interactive Button Animations")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            Spacer()
            
            Button("Tap to Scale") {
                withAnimation(.spring) {
                    isScaling.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
            .scaleEffect(isScaling ? 1.2 : 1.0)
            .accessibilityLabel("Scale Button")
            .accessibilityHint("Toggles between normal and enlarged size when tapped.")

            
            Button("Tap to Rotate") {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isRotating.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
            .rotationEffect(.degrees(isRotating ? 360 : 0))
            .accessibilityLabel("Rotate Button")
            .accessibilityHint("Rotates the button in a full circle when tapped")
            
            Spacer()
        }
        .onAppear {
            subtitle = "Animated Buttons"
        }
    }
}

#Preview {
    @Previewable @State var showToast = false
    @Previewable @State var toastMessage = ""
    
    SwiftUI_Button_Animation_DemoView(subtitle: .constant(nil))
}
