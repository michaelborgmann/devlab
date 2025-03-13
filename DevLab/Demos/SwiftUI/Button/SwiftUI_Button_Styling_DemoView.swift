//
//  SwiftUI_Button_Styling_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI

struct SwiftUI_Button_Styling_DemoView: View {
    
    @Binding var subtitle: String?
    
    var body: some View {
        VStack {
            Button(action: {
                print("Styled Button Tapped")
            }) {
                Text("Styled Button")
                    .font(.title)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .shadow(radius: 10)
            }
        }
        .onAppear {
            subtitle = "Button Styling"
        }
    }
}

#Preview {
    SwiftUI_Button_Styling_DemoView(subtitle: .constant(nil))
}
