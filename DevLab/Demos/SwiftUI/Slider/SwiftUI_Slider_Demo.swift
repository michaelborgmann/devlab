//
//  SwiftUI_Slider_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct SwiftUI_Slider_Demo: DemoProtocol {
    var title = "Slider"
    var infoFileName = "SwiftUI_Slider_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_Slider_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_Slider_Demo())
    }
}
