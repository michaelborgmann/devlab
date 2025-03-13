//
//  SwiftUI_Button_InfoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 13/03/2025.
//

import SwiftUI
import MarkdownUI

struct SwiftUI_Button_InfoView: View {
    
    @State private var markdown: String = ""
    @State private var isLoading = true
    @Binding var viewModel: TechnologyViewModel
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                Markdown(markdown)
                    .padding()
                    .font(.body)
            }
        }
        .onAppear(perform: { loadMarkdownFile() })
    }
    
    private func loadMarkdownFile(filename: String = "SwiftUI_Button_Demo", fileType type: String = "md") {
        
        if let filePath = Bundle.main.path(forResource: filename, ofType: type) {
            
            isLoading.toggle()
            
            do {
                markdown = try String(contentsOfFile: filePath, encoding: .utf8)
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
    @Previewable var viewModel = TechnologyViewModel()
    SwiftUI_Button_InfoView(viewModel: .constant(viewModel))
        .errorAlert(error: .constant(viewModel.error))
}
