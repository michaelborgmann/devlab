//
//  AppKit_NS_Button_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 20/03/2025.
//

#if os(macOS)

import SwiftUI

struct AppKit_NSButton_DemoView: View {
    
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var showInfo = false
    @State private var subtitle: String?
    @State private var customizeAction: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            
            // Spacer ensures the VStack has a valid intrinsic height to layout the TabView correctly.
            Spacer()
            
            TabView {
                
                AppKit_NSButton_BasicViewControllerRepresentable(showToast: $showToast, toastMessage: $toastMessage, subtitle: $subtitle)
                    .tabItem { Text("Basic NSButton") }
                    .accessibilityLabel("AppKit NSButton Demo")
            }
            .buttonStyle(.plain)
            .tabViewStyle(.sidebarAdaptable)
            .accessibility(identifier: "NSButton Demos Tab View")
            .overlay {
                Text(toastMessage)
                    .toast(showToast: $showToast, toastMessage: $toastMessage)
                    .accessibilityLabel(toastMessage)
                    .accessibilityAddTraits(.updatesFrequently)
            }
        }
        .toolbar {
            
            // NOTE: Show demo information.
            ToolbarItemGroup(placement: .automatic) {
                
                if let customizeAction = customizeAction {
                    Button { customizeAction() } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Customize Settings")
                    .accessibilityHint("Opens customization options")
                }
                
                NavigationLink(destination: {
                    AppKit_NSButton_InfoView()
                }, label: {
                    Image(systemName: "info.circle")
                })
                .accessibilityLabel("Show Information")
                .accessibilityHint("Opens the info sheet with details about the demo.")
                .accessibilityValue(showInfo ? "Information sheet is open" : "Information sheet is closed")
            }
        }
        .animation(.easeInOut, value: showToast)
        .navigationTitle("NSButton")
        .accessibilityLabel("NSButton Demo")
    }
}

#Preview {
    NavigationStack {
        AppKit_NSButton_DemoView()
    }
}

#endif
