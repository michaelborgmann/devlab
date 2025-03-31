//
//  SwiftUI_Picker_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct SwiftUI_Picker_Demo: DemoProtocol {
    
    var title = "Picker"
    var infoFileName = "SwiftUI_Picker_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_Picker_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_Picker_Demo())
    }
}
