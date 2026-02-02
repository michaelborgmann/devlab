//
//  CoreMotion_ CMMotionManager_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/02/2026.
//

import SwiftUI

struct CoreMotion_CMMotionManager_Demo: DemoProtocol {
    var title = "CMMotionManager"
    var infoFileName = "CoreMotion_ CMMotionManager_Info"
    var demos: [any DemoPage.Type] = [
        CoreMotion_CMMotionManager_ServiceAvailability_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: CoreMotion_CMMotionManager_Demo())
    }
}
