//
//  SwiftUIButtonStyleType.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI

enum ButtonStyleType: String, CaseIterable {
    
    case automatic = "Automatic"
    case bordered = "Bordered"
    case borderedProminent = "Bordered Prominent"
    case borderless = "Borderless"
    case plain = "Plain"
    
    @ViewBuilder
    func style(_ action: @escaping () -> Void) -> some View {
        switch self {
        case .automatic:
            Button("Tap Me") { action() }
                .accessibilityLabel("Tap the Automatic Button")
        case .bordered:
            Button("Tap Me") { action() }
                .buttonStyle(.bordered)
                .accessibilityLabel("Tap the Bordered Button")
        case .borderedProminent:
            Button("Tap Me") { action() }
                .buttonStyle(.borderedProminent)
                .accessibilityLabel("Tap the Bordered Prominent Button")
        case .borderless:
            Button("Tap Me") { action() }
                .buttonStyle(.borderless)
                .accessibilityLabel("Tap the Borderless Button")
        case .plain:
            Button("Tap Me") { action() }
                .buttonStyle(.plain)
                .accessibilityLabel("Tap the Plain Button")
        }
    }
    
    @ViewBuilder
    static func selector(selectedStyle: Binding<ButtonStyleType>) -> some View {
        
        VStack {
            Text("Select a Button Style")
                .font(.callout)
                .accessibilityLabel("Select a button style")
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 20) {
                    Spacer().frame(width: 0)
                    
                    ForEach(ButtonStyleType.allCases, id: \.self) { style in
                        
                        Button(action: {
                            withAnimation { selectedStyle.wrappedValue = style }
                        }) {
                            Text(style.rawValue)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedStyle.wrappedValue == style ? .blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedStyle.wrappedValue == style ? .white : .black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedStyle.wrappedValue == style ? Color.blue : Color.clear, lineWidth: 2)
                                )
                        }
                        .accessibilityLabel("Select \(style.rawValue) Style")
                        .accessibilityAddTraits(selectedStyle.wrappedValue == style ? .isSelected : [])
                    }
                    Spacer().frame(width: 0)
                }
            }
            .accessibilityValue("Current style: \(selectedStyle.wrappedValue.rawValue)")
        }
    }
}
