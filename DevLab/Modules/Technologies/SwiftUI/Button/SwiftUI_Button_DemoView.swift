//
//  SwiftUI_Button_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/03/2025.
//

import SwiftUI

struct SwiftUI_Button_DemoView: View {
    
    @State private var labelText = "Tap the button!"
    let title = "SwiftUI Button Demo"
    
    let buttonDemos = [
        ("Basic Button", "Tap me to see the basic button."),
        ("Button Styling", "Tap me to see button styling."),
        ("Button Animation", "Tap me to see animation effects."),
        ("Button with Image", "Tap me to see a button with an image."),
        ("Button with Feedback", "Tap me to see haptic feedback.")
    ]
    
    var body: some View {
        VStack {
            
            TabView {
                SwiftUI_Button_Basic_DemoView()
                SwiftUI_Button_Styling_DemoView()
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(
              PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

struct ButtonDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Button_DemoView()
    }
}
