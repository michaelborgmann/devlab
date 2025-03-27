//
//  InfoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 28/03/2025.
//

import SwiftUI
import MarkdownUI

struct InfoView: View {
    
    @State private var markdown: String = ""
    @State private var isLoading = false
    @State var error: Error? = nil
    
    private let fileName: String
    private let fileType: String?
    
    init(fileName: String, fileType: String? = nil) {
        self.fileName = fileName
        self.fileType = fileType
    }
    
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
            loadMarkdownFile(filename: fileName, fileType: fileType)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Information view with markdown content.")
        .accessibilityHint("This view displays content related to slider demos.")
    }
    
    private func loadMarkdownFile(filename: String, fileType type: String?) {
        
        isLoading = true
        
        defer { isLoading = false }
        
        guard let filePath = Bundle.main.path(forResource: filename, ofType: type) else {
            let fileExtension = type.map { ".\($0)" } ?? ""
            error = SettingsViewModel.Error.fileNotFound(filename: "\(filename)\(fileExtension)")
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
    InfoView(fileName: "SwiftUI_Button_Demo", fileType: "md")
}
