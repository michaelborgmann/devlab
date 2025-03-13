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
                
                Section(header: Text("Information")) {
                    NavigationLink("3rd-Party Licenses", destination: LicencesView(viewModel: $viewModel))
                }
            }
        }
        .errorAlert(error: $viewModel.error)
    }
}

#Preview {
    SettingsView()
}
