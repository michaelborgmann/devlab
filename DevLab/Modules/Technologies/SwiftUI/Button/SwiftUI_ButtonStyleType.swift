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
    func style() -> some View {
        switch self {
        case .automatic:
            Button("Tap Me") { print("Button tapped!") }
        case .bordered:
            Button("Tap Me") { print("Button tapped!") }
                .buttonStyle(.bordered)
        case .borderedProminent:
            Button("Tap Me") { print("Button tapped!") }
                .buttonStyle(.borderedProminent)
        case .borderless:
            Button("Tap Me") { print("Button tapped!") }
                .buttonStyle(.borderless)
        case .plain:
            Button("Tap Me") { print("Button tapped!") }
                .buttonStyle(.plain)
        }
    }
    
    @ViewBuilder
    static func selector(selectedStyle: Binding<ButtonStyleType>) -> some View {
        
        VStack {
            Text("Select a Button Style")
                .font(.callout)
            
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
                    }
                    Spacer().frame(width: 0)
                }
            }
        }
    }
}
