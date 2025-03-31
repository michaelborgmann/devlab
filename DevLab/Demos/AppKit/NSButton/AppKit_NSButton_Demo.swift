//
//  AppKit_NSButton_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

#if os(macOS)
import SwiftUI

struct AppKit_NSButton_Demo: DemoProtocol {
    
    var title = "NSButton"
    var infoFileName = "AppKit_NSButton_Info"
    var demos: [any DemoPage.Type] = [
        AppKit_NSButton_BasicViewControllerRepresentable.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: AppKit_NSButton_Demo())
    }
}
#endif
