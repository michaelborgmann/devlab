//
//  SwiftUI_TextFieldStyleType.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/03/2025.
//

import SwiftUI

enum SwiftUI_TextFieldStyleType: String, CaseIterable {
    
    case automatic = "Automatic"
    case plain = "Plain"
    case roundedBorder = "Rounded Border"
    case squareBorder = "Square Border"
    
    @ViewBuilder
    func style(text: Binding<String>) -> some View {
        switch self {
        case .automatic:
            TextField("Enter text", text: text)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .accessibilityLabel("Automatic Text Field")
                .accessibilityHint("Tap to edit text.")
            
        case .plain:
            TextField("Enter text", text: text)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .accessibilityLabel("Plain Text Field")
                .accessibilityHint("Tap to edit text.")
                
        case .roundedBorder:
            TextField("Enter text", text: text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .accessibilityLabel("Rounded Border Text Field")
                .accessibilityHint("Tap to edit text.")
            
        case .squareBorder:
            TextField("Enter text", text: text)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .accessibilityLabel("Square Border Text Field")
                .accessibilityHint("Tap to edit text.")
        }
    }
    
    @ViewBuilder
    static func selector(selectedStyle: Binding<SwiftUI_TextFieldStyleType>) -> some View {
        
        VStack {
            Text("Select a Text Field Style")
                .font(.callout)
                .accessibilityLabel("Select a text field style")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    Spacer().frame(width: 0)
                    
                    ForEach(SwiftUI_TextFieldStyleType.allCases, id: \.self) { style in
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
                        .accessibilityAddTraits(selectedStyle.wrappedValue == style ? .isSelected : [])
                    }
                    Spacer().frame(width: 0)
                }
            }
            .accessibilityValue("Current style: \(selectedStyle.wrappedValue.rawValue)")
        }
    }
}
