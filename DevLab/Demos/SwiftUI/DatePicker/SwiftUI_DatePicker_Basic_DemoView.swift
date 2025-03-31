//
//  SwiftUI_DatePicker_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/03/2025.
//

import SwiftUI

struct SwiftUI_DatePicker_Basic_DemoView: DemoPage {
    
    @State private var selectedStyle: SwiftUI_DatePickerStyleType = .automatic
    @State private var selectedDate: Date = Date()
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("A basic date picker for selecting a date.")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            SwiftUI_DatePickerStyleType.selector(selectedStyle: $selectedStyle)
                .accessibilityLabel("Select a date picker style")
            
            selectedStyle.style(selection: $selectedDate, displayedComponents: .date)
                .accessibilityLabel("Date Picker")
                .accessibilityValue("\(formattedDate(selectedDate))")
                .accessibilityHint("Tap to select a date.")
            
            Text("Selected date: \(formattedDate(selectedDate))")
                .font(.subheadline)
                .foregroundColor(.blue)
                .accessibilityLabel("Currently selected date: \(formattedDate(selectedDate))")
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.subtitle = "Basic Date Picker"
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    SwiftUI_DatePicker_Basic_DemoView(viewModel: $viewModel)
}
