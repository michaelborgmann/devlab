//
//  SettingsView.swift
//  DevLab
//
//  Created by Michael Borgmann on 13/03/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("appTheme") var isDarkMode = false
    @State var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            
            Text("⚙️ Feature Flags & Preferences")
                .navigationTitle("Settings")
                .accessibilityHidden(true)
            
            List {
                
                Section(header: Text("Preferences")
                    .accessibilityLabel("Section header for user preferences.")
                    .accessibilityHint("Contains settings related to theme and customization.")
                ) {
                    Toggle(isOn: $isDarkMode) {
                        Text(isDarkMode ? "Dark Mode Enabled" : "Light Mode Enabled")
                    }
                    .accessibilityLabel(isDarkMode ? "Dark Mode is enabled" : "Light Mode is enabled")
                    .accessibilityHint("Double tap to switch between Light and Dark mode.")
                }
                
                Section(header: Text("Information")
                    .accessibilityLabel("Section header for Information settings.")
                    .accessibilityHint("Contains links related to the app's information."))
                {
                    NavigationLink("3rd-Party Licenses", destination: LicencesView(viewModel: $viewModel))
                        .accessibilityLabel("View 3rd-Party Licenses")
                        .accessibilityHint("Tap to view the licenses for third-party libraries used in the app.")

                }
            }
        }
        .accessibilityElement(children: .combine)
        .errorAlert(error: $viewModel.error)
    }
}

#Preview {
    SettingsView()
}
