//
//  SwiftUI_State_OnOff_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 30/03/2025.
//

import SwiftUI

struct SwiftUI_State_OnOff_DemoView: View {
    
    @State private var isOn: Bool = false
    @Binding var subtitle: String?

    var body: some View {
        
        VStack(spacing: 30) {
            
            Text("On/Off State Demo")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            Spacer()
            
            Button(action: {
                isOn.toggle()
            }) {
                Text(isOn ? "Off" : "On")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(isOn ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            .accessibilityLabel(isOn ? "Turn Off" : "Turn On")
            .accessibilityValue(isOn ? "On" : "Off")
            .accessibilityHint("Tap to toggle the state.")

            
            Text(isOn ? "The switch state is ON" : "The switch state is OFF")
                .font(.subheadline)
                .foregroundColor(.blue)
                .accessibilityLabel("State description")
                .accessibilityValue(isOn ? "On" : "Off")
 
            Spacer()
        }
        .padding()
        .onAppear {
            subtitle = "State On/Off"
        }
    }
}

#Preview {
    NavigationStack {
        SwiftUI_State_OnOff_DemoView(subtitle: .constant(nil))
    }
}
