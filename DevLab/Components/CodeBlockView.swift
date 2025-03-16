//
//  CodeBlockView.swift
//  DevLab
//
//  Created by Michael Borgmann on 15/03/2025.
//

import SwiftUI
import MarkdownUI

struct CodeBlockView: View {
    
    var configuration: CodeBlockConfiguration
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                
                Text(configuration.language ?? "plain text")
                    .font(.caption)
                    .monospaced()
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button {
                    copyToClipboard(configuration.content)
                } label: {
                    Image(systemName: "clipboard")
                }
                .accessibilityLabel("Copy Code")
                .accessibilityHint("Copies the code block to the clipboard")
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.secondarySystemFill))
            .accessibilityElement(children: .combine)
            
            Divider()
            
            ScrollView(.horizontal) {
                
                configuration.label
                    .relativeLineSpacing(.em(0.25))
                    .markdownTextStyle {
                        FontFamilyVariant(.monospaced)
                        FontSize(.em(0.85))
                    }
                    .padding()
                    .accessibilityLabel("Code block content")
            }
        }
        #if os(macOS)
        .background(.quaternary)
        #elseif os(iOS)
        .background(Color(.secondarySystemBackground))
        #endif
        .cornerRadius(8)
        .markdownMargin(top: .zero, bottom: .em(0.8))
    }
    
    private func copyToClipboard(_ string: String) {
        #if os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(string, forType: .string)
        #elseif os(iOS)
        UIPasteboard.general.string = string
        #endif
    }
}

#Preview {
    
    let markdown = """
    ```swift
    let x = 10
    ```
    """
    
    Markdown(markdown)
        .markdownBlockStyle(\.codeBlock) {
            CodeBlockView(configuration: $0)
        }
}
