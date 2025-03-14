//
//  SettingsView.swift
//  DevLab
//
//  Created by Michael Borgmann on 13/03/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @State var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            
            Text("⚙️ Feature Flags & Preferences")
                .navigationTitle("Settings")
                .accessibilityLabel("App settings and preferences.")
                .accessibilityHint("Configure feature flags and user preferences.")
            
            List {
                
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
        .errorAlert(error: $viewModel.error)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    SettingsView()
}
