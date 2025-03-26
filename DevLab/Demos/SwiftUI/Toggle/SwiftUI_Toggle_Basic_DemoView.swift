//
//  SwiftUI_Toggle_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 26/03/2025.
//

import SwiftUI

struct SwiftUI_Toggle_Basic_DemoView: View {
    
    @State private var isOn: Bool = false
    @State private var selectedStyle: SwiftUI_ToggleStyleType = .automatic
    @Binding var subtitle: String?
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("A basic toggle that controls a state.")
                .font(.headline)
                .accessibilityLabel("A basic toggle that controls a state.")
                .accessibilityHint("Tap the toggle to switch its state.")
            
            SwiftUI_ToggleStyleType.selector(selectedStyle: $selectedStyle)
            
            Spacer()
            
            selectedStyle.style(isOn: $isOn)
                .onChange(of: isOn) { _, newValue in
                    subtitle = newValue ? "Basic Toggle (Enabled)" : "Basic Toggle (Disabled)"
                }
                .accessibilityLabel("Feature Toggle")
                .accessibilityValue(isOn ? "Enabled" : "Disabled")
                .accessibilityHint("Double tap to toggle the feature.")
            
            Text(isOn ? "The feature is enabled" : "The feature is disabled")
                .font(.subheadline)
                .foregroundColor(isOn ? .green : .red)
                .transition(.opacity)
            
            Spacer()
        }
        .padding()
        .onAppear {
            subtitle = "Basic Toggle"
        }
    }
}

#Preview {
    SwiftUI_Toggle_Basic_DemoView(subtitle: .constant(nil))
}
