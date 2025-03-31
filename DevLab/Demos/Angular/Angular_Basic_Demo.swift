//
//  Angular_Basic_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct Angular_Basic_Demo: DemoProtocol {
    var title = "Basic"
    var infoFileName = "Angular_Basic_Info"
    var demos: [any DemoPage.Type] = [
        Angular_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: Angular_Basic_Demo())
    }
}
