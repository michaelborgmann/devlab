//
//  SwiftUI_Button_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct SwiftUI_Button_Demo: DemoProtocol {
    
    var title = "Button"
    var infoFileName = "SwiftUI_Button_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_Button_Basic_DemoView.self,
        SwiftUI_Button_Styling_DemoView.self,
        SwiftUI_Button_Animation_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_Button_Demo())
    }
}
