//
//  SwiftUI_Stepper_InfoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/03/2025.
//

import SwiftUI
import MarkdownUI

struct SwiftUI_Stepper_InfoView: View {
    
    @State private var markdown: String = ""
    @State private var isLoading = false
    @State var error: Error? = nil
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .accessibilityLabel("Content is loading.")
                    .accessibilityValue("Loading content, please wait.")
            } else {
                Markdown(markdown)
                    .markdownBlockStyle(\.codeBlock) {
                        CodeBlockView(configuration: $0)
                    }
                    .padding()
                    .font(.body)
                    .textSelection(.enabled)
                    .accessibilityLabel("Markdown content.")
                    .accessibilityValue("The markdown content has been loaded.")
            }
        }
        .errorAlert(error: $error)
        .onAppear {
            loadMarkdownFile()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Information view with markdown content.")
        .accessibilityHint("This view displays content related to stepper demos.")
    }
    
    private func loadMarkdownFile(filename: String = "SwiftUI_Stepper_Demo", fileType type: String = "md") {
        
        isLoading = true
        
        defer { isLoading = false }
        
        guard let filePath = Bundle.main.path(forResource: filename, ofType: type) else {
            error = SettingsViewModel.Error.fileNotFound(filename: "\(filename).\(type)")
            return
        }
        
        do {
            markdown = try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            self.error = SettingsViewModel.Error.loadingFailure(filename: filePath)
        }
    }
}

#Preview {
    SwiftUI_Stepper_InfoView()
}
