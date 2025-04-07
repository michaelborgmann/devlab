//
//  SwiftUI_StateObject_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/04/2025.
//

import SwiftUI

struct SwiftUI_StateObject_Demo: DemoProtocol {
    var title = "StateObject"
    var infoFileName = "SwiftUI_v_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_StateObject_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_StateObject_Demo())
    }
}
