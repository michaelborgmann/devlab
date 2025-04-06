//
//  SwiftUI_ObservedObject_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 06/04/2025.
//

import SwiftUI

struct SwiftUI_ObservedObject_Demo: DemoProtocol {
    var title = "ObservedObject"
    var infoFileName = "SwiftUI_ObservedObject_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_ObservedObject_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_ObservedObject_Demo())
    }
}
