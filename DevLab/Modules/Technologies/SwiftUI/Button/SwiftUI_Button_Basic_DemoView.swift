//
//  SwiftUI_Button_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI

struct SwiftUI_Button_Basic_DemoView: View {
    
    @State private var buttonText = "Tap me!"
    @State private var count = 0
    
    @State private var selectedStyle: ButtonStyleType = .automatic

    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("A basic button that triggers an action.")
                .font(.headline)
            
            ButtonStyleType.selector(selectedStyle: $selectedStyle)
            
            Spacer()
            
            selectedStyle.style()
            
            Spacer()
        }
        .navigationTitle("Basic Button")
    }
}

#Preview {
    SwiftUI_Button_Basic_DemoView()
}
