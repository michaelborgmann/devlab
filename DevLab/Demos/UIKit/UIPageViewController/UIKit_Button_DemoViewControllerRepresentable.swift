//
//  UIKit_Button_DemoViewControllerRepresentable.swift
//  DevLab
//
//  Created by Michael Borgmann on 18/03/2025.
//

#if os(iOS)

import SwiftUI
import UIKit

// This struct wraps the UIKit ViewController inside a SwiftUI view.
struct UIKit_Button_DemoViewControllerRepresentable: UIViewControllerRepresentable {
    
    let navController =  UINavigationController()
    
    // The required method to create and configure the view controller.
//    func makeUIViewController(context: Context) -> UINavigationController {
//        navController.setNavigationBarHidden(true, animated: false)
//        let viewController = UIViewController()
//        navController.addChild(viewController)
//        return navController
//    }
    
//    func makeUIViewController(context: Context) -> UINavigationController {
//        let demoVC = UIKit_Button_DemoViewController()
//        let navController = UINavigationController(rootViewController: demoVC)
//        return navController
//    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let viewController = UIKit_Button_DemoViewController()
        navController.addChild(viewController)
        return navController
    }
    
    // The required method to update the view controller (if needed).
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Handle updates to the UIKit view controller if needed.
    }
}

#Preview {
    NavigationStack {
        UIKit_Button_DemoViewControllerRepresentable()
            .navigationTitle("UIButton")
    }
}

#endif
