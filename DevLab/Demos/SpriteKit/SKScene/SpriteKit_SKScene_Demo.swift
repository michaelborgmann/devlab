//
//  SpriteKit_SKScene_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//


import SwiftUI

struct SpriteKit_SKScene_Demo: DemoProtocol {
    
    var title = "SKScene"
    var infoFileName = "SpriteKit_SKScene_Info"
    var demos: [any DemoPage.Type] = [
        SpriteKit_SKScene_Basic_DemoView.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: SpriteKit_SKScene_Demo())
    }
}
