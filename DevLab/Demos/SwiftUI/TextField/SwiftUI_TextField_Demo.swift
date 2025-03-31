//
//  SwiftUI_TextField_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct SwiftUI_TextField_Demo: DemoProtocol {
    
    var title = "TextField"
    var infoFileName = "SwiftUI_TextField_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_TextField_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_TextField_Demo())
    }
}
