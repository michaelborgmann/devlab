//
//  SwiftUI_DatePickerStyleType.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/03/2025.
//

import SwiftUI

enum SwiftUI_DatePickerStyleType: String, CaseIterable {
    
    case automatic = "Automatic"
    case compact = "Compact"
    case graphical = "Graphical"
    
    #if os(iOS)
    case wheel = "Wheel"
    #endif
    
    #if os(macOS)
    case field = "Field"
    case stepperField = "Stepper Field"
    #endif
    
    @ViewBuilder
    func style(selection: Binding<Date>, displayedComponents: DatePicker.Components) -> some View {
        switch self {
        case .automatic:
            DatePicker("Select a date", selection: selection, displayedComponents: displayedComponents)
                .datePickerStyle(.automatic)
                .accessibilityLabel("Automatic Date Picker")
                
        case .compact:
            DatePicker("Select a date", selection: selection, displayedComponents: displayedComponents)
                .datePickerStyle(.compact)
                .accessibilityLabel("Compact Date Picker")
                
        case .graphical:
            DatePicker("Select a date", selection: selection, displayedComponents: displayedComponents)
                .datePickerStyle(.graphical)
                .accessibilityLabel("Graphical Date Picker")
                
        #if os(iOS)
        case .wheel:
            DatePicker("Select a date", selection: selection, displayedComponents: displayedComponents)
                .datePickerStyle(.wheel)
                .accessibilityLabel("Wheel Date Picker")
        #endif
            
        #if os(macOS)
        case .field:
            DatePicker("Select a date", selection: selection, displayedComponents: displayedComponents)
                .datePickerStyle(.field)
                .accessibilityLabel("Field Date Picker")
            
        case .stepperField:
            DatePicker("Select a date", selection: selection, displayedComponents: displayedComponents)
                .datePickerStyle(.stepperField)
                .accessibilityLabel("Stepper Field Date Picker")
        #endif
        }
    }
    
    @ViewBuilder
    static func selector(selectedStyle: Binding<SwiftUI_DatePickerStyleType>) -> some View {
        
        VStack {
            Text("Select a Date Picker Style")
                .font(.callout)
                .accessibilityLabel("Select a date picker style")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    Spacer().frame(width: 0)
                    
                    ForEach(SwiftUI_DatePickerStyleType.allCases, id: \.self) { style in
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
