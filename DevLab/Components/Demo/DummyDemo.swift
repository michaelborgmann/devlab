//
//  DummyDemo.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

protocol DemoProtocol {
    var title: String { get }
    var infoFileName: String { get }
    var demos: [any DemoPage.Type] { get }
    func createDemos(viewModel: Binding<DemoViewModel>) -> [any DemoPage]
}

extension DemoProtocol {
    func createDemos(viewModel: Binding<DemoViewModel>) -> [any DemoPage] {
        demos.map {
            $0.init(viewModel: viewModel)
        }
    }
}

struct DummyDemo: DemoProtocol {
    var title = "Dummy"
    var infoFileName = "DummyInfo"
    var demos: [any DemoPage.Type] = [
        DummyDemoPageView.self,
        DummyDemoPageView.self,
        DummyDemoPageView.self
    ]
}
