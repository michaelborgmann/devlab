//
//  SwiftUI_Binding_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 05/04/2025.
//

import SwiftUI

struct SwiftUI_Binding_DemoView: DemoPage {
    
    @State private var isOn: Bool = false
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("@Binding Demo")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
                .accessibilityIdentifier("Title")
            
            Spacer()
            
            // 🔵 Parent Section
            VStack {
                Text("Parent View")
                    .font(.subheadline)
                    .bold()
                    .accessibilityAddTraits(.isHeader)

                Text("isOn = \(isOn.description)")
                    .accessibilityLabel("Binding value")
                    .accessibilityValue(isOn ? "On" : "Off")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier("ParentViewSection")
            
            // 🟠 Child Section
            VStack {
                Text("Child View")
                    .font(.subheadline)
                    .bold()
                    .accessibilityAddTraits(.isHeader)
                
                ToggleButton(isOn: $isOn)
            }
            .padding()
            .background(Color.orange.opacity(0.1))
            .cornerRadius(10)
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier("ChildViewSection")
            
            Spacer()
        }

        .padding()
        .onAppear {
            viewModel.subtitle = "@Binding Shared State"
        }
    }
}

struct ToggleButton: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            isOn.toggle()
        }) {
            Text(isOn ? "Turn Off" : "Turn On")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(isOn ? Color.red : Color.green)
                .cornerRadius(10)
        }
        .accessibilityLabel(isOn ? "Turn Off Button" : "Turn On Button")
        .accessibilityValue(isOn ? "On" : "Off")
        .accessibilityHint("Toggles the shared binding value in the parent view.")
        .accessibilityIdentifier("BindingToggleButton")
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    SwiftUI_Binding_DemoView(viewModel: $viewModel)
}
