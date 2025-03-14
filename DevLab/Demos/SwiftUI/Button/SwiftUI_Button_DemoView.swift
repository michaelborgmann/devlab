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
    
    var body: some View {
        VStack {
            
            // Spacer ensures the VStack has a valid intrinsic height to layout the TabView correctly.
            Spacer()
            
            TabView {
                
                SwiftUI_Button_Basic_DemoView(showToast: $showToast, toastMessage: $toastMessage, subtitle: $subtitle)
                    .accessibilityLabel("Basic Button Demo")
                
                SwiftUI_Button_Styling_DemoView(subtitle: $subtitle)
                    .accessibilityLabel("Button Styling Demo")
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(
                PageIndexViewStyle(backgroundDisplayMode: .always))
            .accessibility(identifier: "Button Demos Tab View")
            .overlay {
                Text(toastMessage)
                    .toast(showToast: $showToast, toastMessage: $toastMessage)
                    .accessibilityLabel(toastMessage)
                    .accessibilityAddTraits(.updatesFrequently)
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                subtitle.map {
                    Text($0)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel($0)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { showInfo.toggle() }) {
                    Image(systemName: "info.circle")
                }
                .accessibilityLabel("Show Information")
                .accessibilityHint("Opens the info sheet with details about the demo.")
                .accessibilityValue(showInfo ? "Information sheet is open" : "Information sheet is closed")
            }
        }
        .sheet(isPresented: $showInfo) {
            SwiftUI_Button_InfoView()
        }
        .animation(.easeInOut, value: showToast)
        .navigationTitle("Button")
        .accessibilityLabel("Button Demo")
    }
}

#Preview {
    SwiftUI_Button_DemoView()
}
