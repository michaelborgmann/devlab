//
//  React_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 21/03/2025.
//

import SwiftUI

struct React_Basic_DemoView: View {
    
    @State private var showInfo = false
    @State private var subtitle: String?
    
    var demoURL: URL? {
        URL(string: "https://hacknthrash.github.io/react-demos/")
    }
    
    var body: some View {
        if let demoURL = demoURL {
            applyModifiers(
                WebView(url: demoURL)
                    .accessibilityLabel("React Demo Web Page")
                    .accessibilityHint("Displays a demo of React applications.")
            )
        } else {
            applyModifiers(
                Text("Failed to load demo.")
                    .accessibilityLabel("Demo loading failed")
                    .accessibilityHint("The page could not be loaded, please check your connection or try again.")
            )
        }
    }
    
    func applyModifiers<Content: View>(_ view: Content) -> some View {
        view
            .toolbar {
                #if os(iOS)
                
                ToolbarItem(placement: .principal) {
                    subtitle.map {
                        Text($0)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .accessibilityLabel($0)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showInfo.toggle() } label: {
                        Image(systemName: "info.circle")
                    }
                    .accessibilityLabel("Show Information")
                    .accessibilityHint("Opens the info sheet with details about the demo.")
                    .accessibilityValue(showInfo ? "Information sheet is open" : "Information sheet is closed")
                }
                #endif
            }
            .sheet(isPresented: $showInfo) {
                React_Basic_InfoView()
                    .presentationSizing(.page)
                    .accessibilityLabel("React Basic Info Sheet")
                    .accessibilityHint("Displays additional information about the demo.")
            }
            .onAppear {
                subtitle = "React Basic"
            }
            .navigationTitle("React")
            .accessibilityLabel("React Basic Demo")
    }
}

#Preview {
    NavigationStack {
        React_Basic_DemoView()
    }
}
