//
//  SwiftUI_Toggle_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct SwiftUI_Toggle_Demo: DemoProtocol {
    
    var title = "Toggle"
    var infoFileName = "SwiftUI_Toggle_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_Toggle_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_Toggle_Demo())
    }
}
