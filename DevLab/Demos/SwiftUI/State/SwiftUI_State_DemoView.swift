//
//  SwiftUI_State_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 30/03/2025.
//

import SwiftUI

struct SwiftUI_State_DemoView: View {
    
    @State private var showInfo = false
    @State private var subtitle: String?
    @State private var customizeAction: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            
            // Spacer ensures the VStack has a valid intrinsic height to layout the TabView correctly.
            Spacer()
            
            TabView {
                
                SwiftUI_State_OnOff_DemoView(subtitle: $subtitle)
                    .tabItem { Text("State On/Off") }
                    .accessibilityLabel("State On/Off Demo")
            }
            #if os(macOS)
            .buttonStyle(.plain)
            .tabViewStyle(.sidebarAdaptable)
            #elseif os(iOS)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            #endif
            .accessibility(identifier: "State Demos Tab View")
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
            ToolbarItemGroup(placement: .automatic) {
                
                if let customizeAction = customizeAction {
                    Button { customizeAction() } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Customize Settings")
                    .accessibilityHint("Opens customization options")
                }
                
                NavigationLink(destination: {
                    InfoView(fileName: "SwiftUI_State_Demo", fileType: "md")
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
            #endif
        }
        .sheet(isPresented: $showInfo) {
            InfoView(fileName: "SwiftUI_State_Demo", fileType: "md")
                .presentationSizing(.page)
        }
        .navigationTitle("State On/Off")
        .accessibilityLabel("State On/Off Demo")
    }
}

#Preview {
    NavigationStack {
        SwiftUI_State_DemoView()
    }
}
