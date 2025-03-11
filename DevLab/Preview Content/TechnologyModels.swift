//
//  TechnologyModels.swift
//  DevLab
//
//  Created by Michael Borgmann on 08/03/2025.
//

import Foundation

extension TechnologyEcosystem {
    static func seed() -> TechnologyEcosystem {
        TechnologyEcosystem(name: "Apple", technologies: Technology.seed())
    }
}

extension Technology {
    static func seed() -> [Technology] {
        [Technology(name: "SwiftUI", sections: TechnologySection.seed())]
    }
}

extension TechnologySection {
    static func seed() -> [TechnologySection] {
        [TechnologySection(name: "Views", demos: Demo.seed())]
    }
}

extension Demo {
    static func seed() -> [Demo] {
        [Demo(title: "Preview Content", view: "PreviewContentDemoView")]
    }
}
