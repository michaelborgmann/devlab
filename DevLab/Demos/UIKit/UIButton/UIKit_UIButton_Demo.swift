//
//  UIKit_UIButton_Demo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

#if os(iOS)
import SwiftUI

struct UIKit_UIButton_Demo: DemoProtocol {
    
    var title = "UIButton"
    var infoFileName = "UIKit_UIButton_Info"
    var demos: [any DemoPage.Type] = [
        UIKit_Button_BasicViewControllerRepresentable.self
    ]
}

#Preview {
    NavigationStack {
        DemoView(demo: UIKit_UIButton_Demo())
    }
}
#endif
