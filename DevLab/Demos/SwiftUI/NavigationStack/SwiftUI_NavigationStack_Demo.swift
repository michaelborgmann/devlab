//
//  SwiftUI_Navigation_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 13/09/2025.
//

import Foundation

struct SwiftUI_NavigationStack_Demo: DemoProtocol {
    var title = "NavigationStack"
    var infoFileName = "SwiftUI_NavigationStack_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_NavigationStack_Basic_DemoView.self
    ]
}
