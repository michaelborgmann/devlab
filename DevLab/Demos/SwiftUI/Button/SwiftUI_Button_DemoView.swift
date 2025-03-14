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
                SwiftUI_Button_Styling_DemoView(subtitle: $subtitle)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(
                PageIndexViewStyle(backgroundDisplayMode: .always))
            .overlay {
                Text(toastMessage)
                    .toast(showToast: $showToast)
            }
            .animation(.easeInOut, value: showToast)
        }
        .toolbar {
            if let subtitle = subtitle {
                ToolbarItem(placement: .principal) {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { showInfo.toggle() }) {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showInfo) {
            SwiftUI_Button_InfoView()
        }
        .navigationTitle("Button")
    }
}

#Preview {
    SwiftUI_Button_DemoView()
}
