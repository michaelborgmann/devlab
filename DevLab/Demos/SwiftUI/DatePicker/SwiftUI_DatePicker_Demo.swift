//
//  SwiftUI_DatePicker_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct SwiftUI_DatePicker_Demo: DemoProtocol {
    
    var title = "DatePicker"
    var infoFileName = "SwiftUI_DatePicker_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_DatePicker_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_DatePicker_Demo())
    }
}
