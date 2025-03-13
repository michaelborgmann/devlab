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
            } else {
                Markdown(licenceText)
                    .padding()
                    .font(.body)
            }
        }
        .navigationTitle("Third-Party Licenses")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: { loadLicenses() })
    }

    private func loadLicenses(filename: String = "THIRD_PARTY_LICENSES", fileType type: String = "md") {
        if let filePath = Bundle.main.path(forResource: filename, ofType: type) {
            
            isLoading.toggle()
            
            do {
                licenceText = try String(contentsOfFile: filePath, encoding: .utf8)
            } catch {
                viewModel.error = SettingsViewModel.Error.loadingFailure(filename: filePath)
            }
        } else {
            isLoading.toggle()
            viewModel.error = SettingsViewModel.Error.fileNotFound(filename: "\(filename).\(type)")
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
