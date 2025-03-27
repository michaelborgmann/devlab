//
//  SwiftUI_Stepper_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/03/2025.
//

import SwiftUI

struct SwiftUI_Stepper_Basic_DemoView: View {
    
    @State private var value: Int = 0
    @State private var stepSize: Int = 1
    @Binding var subtitle: String?
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("A basic stepper that increments or decrements a value.")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            Stepper("Value: \(value)", value: $value, in: 0...100, step: stepSize)
                .onChange(of: value) { _, newValue in
                    subtitle = "Stepper Value: \(newValue)"
                }
                .accessibilityValue("\(value)")
                .accessibilityHint("Tap plus to increase, minus to decrease.")
            
            Spacer()
        }
        .padding()
        .onAppear {
            subtitle = "Basic Stepper"
        }
    }
}

#Preview {
    SwiftUI_Stepper_Basic_DemoView(subtitle: .constant(nil))
}
