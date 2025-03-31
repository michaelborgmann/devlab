//
//  SwiftUI_Stepper_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

struct SwiftUI_Stepper_Demo: DemoProtocol {
    
    var title = "Stepper"
    var infoFileName = "SwiftUI_Stepper_Info"
    var demos: [any DemoPage.Type] = [
        SwiftUI_Stepper_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_Stepper_Demo())
    }
}
