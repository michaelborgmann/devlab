//
//  SwiftUI_ToggleStyleType.swift
//  DevLab
//
//  Created by Michael Borgmann on 26/03/2025.
//

import SwiftUI

enum SwiftUI_ToggleStyleType: String, CaseIterable {
    
    case automatic = "Automatic"
    case button = "Button"
    case `switch` = "Switch"
    
    #if os(macOS)
    case checkbox = "Checkbox"
    #endif
    
    @ViewBuilder
    func style(isOn: Binding<Bool>) -> some View {
        switch self {
        case .automatic:
            Toggle("Enable Feature", isOn: isOn)
                .toggleStyle(.automatic)
                .accessibilityLabel("Automatic Toggle")
                .accessibilityValue(isOn.wrappedValue ? "Enabled" : "Disabled")
                .accessibilityHint("Double tap to toggle the feature.")
            
        case .button:
            Toggle("Enable Feature", isOn: isOn)
                .toggleStyle(.button)
                .accessibilityLabel("Button Toggle")
                .accessibilityValue(isOn.wrappedValue ? "Enabled" : "Disabled")
                .accessibilityHint("Double tap to toggle the feature.")
            
        case .switch:
            Toggle("Enable Feature", isOn: isOn)
                .toggleStyle(.switch)
                .accessibilityLabel("Switch Toggle")
                .accessibilityValue(isOn.wrappedValue ? "Enabled" : "Disabled")
                .accessibilityHint("Double tap to toggle the feature.")
            
        #if os(macOS)
        case .checkbox:
            Toggle("Enable Feature", isOn: isOn)
                .toggleStyle(.checkbox)
                .accessibilityLabel("Checkbox Toggle")
                .accessibilityValue(isOn.wrappedValue ? "Enabled" : "Disabled")
                .accessibilityHint("Double tap to toggle the feature.")
        #endif
        }
    }
    
    @ViewBuilder
    static func selector(selectedStyle: Binding<SwiftUI_ToggleStyleType>) -> some View {
        VStack {
            Text("Select a Toggle Style")
                .font(.callout)
                .accessibilityLabel("Select a toggle style")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    Spacer().frame(width: 0)
                    
                    ForEach(SwiftUI_ToggleStyleType.allCases, id: \ .self) { style in
                        Button(action: {
                            withAnimation { selectedStyle.wrappedValue = style }
                        }) {
                            Text(style.rawValue)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedStyle.wrappedValue == style ? .blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedStyle.wrappedValue == style ? .white : .secondary)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedStyle.wrappedValue == style ? Color.blue : Color.clear, lineWidth: 2)
                                )
                        }
                        .accessibilityLabel("Select \(style.rawValue) Style")
                        .accessibilityHint("Double tap to switch to this style.")
                        .accessibilityAddTraits(selectedStyle.wrappedValue == style ? .isSelected : [])
                    }
                    Spacer().frame(width: 0)
                }
            }
            .accessibilityValue("Current style: \(selectedStyle.wrappedValue.rawValue)")
        }
    }
}

#Preview {
    SwiftUI_ToggleStyleType.selector(selectedStyle: .constant(.automatic))
}
