//
//  UIKit_UIButton_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 19/03/2025.
//

#if os(iOS)

import SwiftUI

struct UIKit_UIButton_DemoView: View {
    
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
                
                UIKit_Button_BasicViewControllerRepresentable(showToast: $showToast, toastMessage: $toastMessage, subtitle: $subtitle)
                    .tabItem { Text("Basic UIButton") }
                    .accessibilityLabel("UIKit UIButton Demo")
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .accessibility(identifier: "UIButton Demos Tab View")
            .overlay {
                Text(toastMessage)
                    .toast(showToast: $showToast, toastMessage: $toastMessage)
                    .accessibilityLabel(toastMessage)
                    .accessibilityAddTraits(.updatesFrequently)
            }
            
        }
        .toolbar {
            
            // NOTE: iOS only, centers subtitle in navigation bar.
            ToolbarItem(placement: .principal) {
                subtitle.map {
                    Text($0)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel($0)
                }
            }
            
            // NOTE: Show demo information.
            ToolbarItemGroup(placement: .topBarTrailing) {
                
                if let customizeAction = customizeAction {
                    Button { customizeAction() } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Customize Settings")
                    .accessibilityHint("Opens customization options")
                }
                
                Button { showInfo.toggle() } label: {
                    Image(systemName: "info.circle")
                }
                .accessibilityLabel("Show Information")
                .accessibilityHint("Opens the info sheet with details about the demo.")
                .accessibilityValue(showInfo ? "Information sheet is open" : "Information sheet is closed")
            }
        }
        .sheet(isPresented: $showInfo) {
            InfoView(fileName: "UIKit_UIButton_Demo", fileType: "md")
                .presentationSizing(.page)
        }
        .animation(.easeInOut, value: showToast)
        .navigationTitle("UIButton")
        .accessibilityLabel("UIButton Demo")
    }
}

#Preview {
    NavigationStack {
        UIKit_UIButton_DemoView()
    }
}

#endif
