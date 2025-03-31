//
//  SwiftUI_State_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct SwiftUI_State_Demo: DemoProtocol {
    var title = "State"
    var infoFileName = "SwiftUI_State_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_State_OnOff_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_State_Demo())
    }
}
