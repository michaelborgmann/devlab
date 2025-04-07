//
//  SwiftUI_EnvironmentObject_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/04/2025.
//

import SwiftUI

struct SwiftUI_EnvironmentObject_Demo: DemoProtocol {
    var title = "EnvironmentObject"
    var infoFileName = "SwiftUI_EnvironmentObject_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_EnvironmentObject_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_EnvironmentObject_Demo())
    }
}
