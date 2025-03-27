//
//  Angular_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 19/03/2025.
//

import SwiftUI

struct Angular_Basic_DemoView: View {
    
    @State private var showInfo = false
    @State private var subtitle: String?
    
    var demoURL: URL? {
        URL(string: "https://hacknthrash.github.io/angular-demos/")
    }
    
    var body: some View {
        if let demoURL = demoURL {
            applyModifiers(
                WebView(url: demoURL)
                    .accessibilityLabel("Angular Demo Web Page")
                    .accessibilityHint("Displays a demo of Angular applications.")
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
                InfoView(fileName: "Angular_Basic_Demo", fileType: "md")
                    .presentationSizing(.page)
                    .accessibilityLabel("Angular Basic Info Sheet")
                    .accessibilityHint("Displays additional information about the demo.")
            }
            .onAppear {
                subtitle = "Angular Basic"
            }
            .navigationTitle("Angular")
            .accessibilityLabel("Angular Basic Demo")
    }
}

#Preview {
    NavigationStack {
        Angular_Basic_DemoView()
    }
}
