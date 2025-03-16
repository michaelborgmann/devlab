//
//  LicencesView.swift
//  DevLab
//
//  Created by Michael Borgmann on 13/03/2025.
//

import SwiftUI
import MarkdownUI

struct LicencesView: View {
    
    @State private var licenceText: String = ""
    @State private var isLoading = true
    @Binding var viewModel: SettingsViewModel

    var body: some View {
        ScrollView {
            
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .accessibilityLabel("Content is loading.")
                    .accessibilityValue("Loading content, please wait.")
            } else {
                Markdown(licenceText)
                    .padding()
                    .font(.body)
                    .accessibilityLabel("Markdown content.")
                    .accessibilityValue("The markdown content has been loaded.")
            }
        }
        .navigationTitle("Third-Party Licenses")
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .onAppear(perform: { loadLicenses() })
        .accessibilityLabel("Information view with markdown content.")
        .accessibilityHint("This view displays information about third-party licenses used in the app.")
    }

    private func loadLicenses(filename: String = "THIRD_PARTY_LICENSES", fileType type: String = "md") {
        
        isLoading = true
        
        defer { isLoading = false }
        
        guard let filePath = Bundle.main.path(forResource: filename, ofType: type) else {
            viewModel.error = SettingsViewModel.Error.fileNotFound(filename: "\(filename).\(type)")
            return
        }
        
        do {
            licenceText = try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            viewModel.error = SettingsViewModel.Error.loadingFailure(filename: filePath)
        }
    }
}

#Preview {
    
    @Previewable var viewModel = SettingsViewModel()
    
    return NavigationStack {
        LicencesView(viewModel: .constant(viewModel))
    }
    .errorAlert(error: .constant(viewModel.error))
}
