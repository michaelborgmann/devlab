//
//  SwiftUI_Binding_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 05/04/2025.
//

import SwiftUI

struct SwiftUI_Binding_Demo: DemoProtocol {
    var title = "Binding"
    var infoFileName = "SwiftUI_Binding_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_Binding_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_Binding_Demo())
    }
}
