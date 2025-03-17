//
//  SwiftUI_Button_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/03/2025.
//

import SwiftUI

struct SwiftUI_Button_DemoView: View {
    
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
                
                SwiftUI_Button_Basic_DemoView(showToast: $showToast, toastMessage: $toastMessage, subtitle: $subtitle)
                    .accessibilityLabel("Basic Button Demo")
                    .tabItem { Text("Basic Button") }
                
                SwiftUI_Button_Styling_DemoView(showToast: $showToast, toastMessage: $toastMessage, subtitle: $subtitle, customizeAction: $customizeAction)
                    .accessibilityLabel("Button Styling Demo")
                    .tabItem { Text("Button Styling") }
                
                SwiftUI_Button_Animation_DemoView(subtitle: $subtitle)
                    .tabItem { Text("Button Animation") }
            }
            #if os(macOS)
            .buttonStyle(.plain)
            .tabViewStyle(.sidebarAdaptable)
            #elseif os(iOS)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            #endif
            .accessibility(identifier: "Button Demos Tab View")
            .overlay {
                Text(toastMessage)
                    .toast(showToast: $showToast, toastMessage: $toastMessage)
                    .accessibilityLabel(toastMessage)
                    .accessibilityAddTraits(.updatesFrequently)
            }
            
        }
        .toolbar {
            
            // NOTE: iOS only, centers subtitle in navigation bar.
            #if os(iOS)
            ToolbarItem(placement: .principal) {
                subtitle.map {
                    Text($0)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel($0)
                }
            }
            #endif
            
            // NOTE: Show demo information.
            #if os(macOS)
            ToolbarItem(placement: .automatic) {
                NavigationLink(destination: {
                    SwiftUI_Button_InfoView()
                }, label: {
                    Image(systemName: "info.circle")
                })
                .accessibilityLabel("Show Information")
                .accessibilityHint("Opens the info sheet with details about the demo.")
                .accessibilityValue(showInfo ? "Information sheet is open" : "Information sheet is closed")
            }
            #elseif os(iOS)
            ToolbarItemGroup(placement: .topBarTrailing) {
                
                if let customizeAction = customizeAction {
                    Button { customizeAction() } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
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
            SwiftUI_Button_InfoView()
                .presentationSizing(.page)
        }
        .animation(.easeInOut, value: showToast)
        .navigationTitle("Button")
        .accessibilityLabel("Button Demo")
    }
}

#Preview {
    NavigationStack {
        SwiftUI_Button_DemoView()
    }
}
