//
//  VueJS_Basic_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct VueJS_Basic_Demo: DemoProtocol {
    var title = "Basic"
    var infoFileName = "VueJS_Basic_Info"
    var demos: [any DemoPage.Type] = [
        VueJS_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: VueJS_Basic_Demo())
    }
}
