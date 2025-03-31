//
//  React_Basic_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct React_Basic_Demo: DemoProtocol {
    var title = "Basic"
    var infoFileName = "React_Basic_Info"
    var demos: [any DemoPage.Type] = [
        React_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: React_Basic_Demo())
    }
}
