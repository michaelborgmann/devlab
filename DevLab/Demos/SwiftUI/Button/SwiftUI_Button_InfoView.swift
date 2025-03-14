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
    @State private var isLoading = false
    @State var error: Error? = nil
    
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
        .errorAlert(error: $error)
        .onAppear {
            loadMarkdownFile()
        }
    }
    
    private func loadMarkdownFile(filename: String = "SwiftUI_Button_Demo", fileType type: String = "md") {
        
        defer { isLoading = false }
        
        isLoading = true
        
        if let filePath = Bundle.main.path(forResource: filename, ofType: type) {
            do {
                markdown = try String(contentsOfFile: filePath, encoding: .utf8)
            } catch {
                self.error = SettingsViewModel.Error.loadingFailure(filename: filePath)
            }
        } else {
            error = SettingsViewModel.Error.fileNotFound(filename: "\(filename).\(type)")
        }
    }
}

#Preview {
    SwiftUI_Button_InfoView()
}
