//
//  SwiftUI_PickerStyleType.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/03/2025.
//

import SwiftUI

enum SwiftUI_PickerStyleType: String, CaseIterable {
    
    case automatic = "automatic"
    case inline = "inline"
    case menu = "menu"
    case segmented = "segmented"
    case palette = "palette"
    
    #if os(iOS)
    case navigationLink = "navigationLink"
    case wheel = "wheel"
    #elseif os(macOS)
    case radioGroup = "radioGroup"
    #endif
    
    @ViewBuilder
    func style(selection: Binding<Int>, options: [String]) -> some View {
        switch self {
        case .automatic:
            Picker("Select an option", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(.automatic)
            .accessibilityLabel("Automatic Picker")
            .accessibilityHint("Tap or swipe to select an option.")
            
        case .segmented:
            Picker("Select an option", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .accessibilityLabel("Segmented Picker")
            .accessibilityHint("Tap to select an option.")
            
        case .menu:
            Picker("Select an option", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(.menu)
            .accessibilityLabel("Menu Picker")
            .accessibilityHint("Tap to open the menu and select an option.")
            
        case .inline:
            Picker("Select an option", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(.inline)
            .accessibilityLabel("Inline Picker")
            .accessibilityHint("Swipe to select an option.")
            
        case .palette:
            Picker("Select an option", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(.palette)
            .accessibilityLabel("Palette Picker")
            .accessibilityHint("Swipe to select an option.")
            
        #if os(iOS)
        case .wheel:
            Picker("Select an option", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(.wheel)
            .accessibilityLabel("Wheel Picker")
            .accessibilityHint("Swipe to change the selected option.")
                                
        case .navigationLink:
            Picker("Select an option", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(.navigationLink)
            .accessibilityLabel("NavigationLink Picker")
            .accessibilityHint("Tap to open the navigation link.")
        #endif
            
        #if os(macOS)
        case .radioGroup:
            Picker("Select an option", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(.radioGroup)
            .accessibilityLabel("RadioGroup Picker")
            .accessibilityHint("Click to select an option.")
        #endif
        }
    }
    
    @ViewBuilder
    static func selector(selectedStyle: Binding<SwiftUI_PickerStyleType>, options: [String]) -> some View {
        
        VStack {
            Text("Select a Picker Style")
                .font(.callout)
                .accessibilityLabel("Select a picker style")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    Spacer().frame(width: 0)
                    
                    ForEach(SwiftUI_PickerStyleType.allCases, id: \.self) { style in
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
                        .accessibilityValue("Current style: \(style.rawValue)")
                    }
                    Spacer().frame(width: 0)
                }
            }
            .accessibilityValue("Current style: \(selectedStyle.wrappedValue.rawValue)")
        }
    }
}

#Preview {
    SwiftUI_PickerStyleType.selector(selectedStyle: .constant(.automatic), options: ["Option 1", "Option 2", "Option 3"])
}
