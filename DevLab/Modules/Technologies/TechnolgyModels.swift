//
//  TechnolgyModels.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import Foundation

// Apple, 3rd Party, Web
struct TechnologyEcosystem: Codable, Identifiable {
    let id = UUID()
    let name: String
    let technologies: [Technology]
    
    private enum CodingKeys: String, CodingKey {
        case name = "ecosystem", technologies
    }
}

// Swift, SwiftUI, UIKit
struct Technology: Codable, Identifiable {
    let id = UUID()
    let name: String
    let sections: [TechnologySection]
    
    private enum CodingKeys: String, CodingKey {
        case name, sections
    }
}

// Controls & Indicators, Views & Controls, etc.
struct TechnologySection: Codable, Identifiable {
    let id = UUID()
    let name: String
    let demos: [Demo]
    
    private enum CodingKeys: String, CodingKey {
        case name, demos
    }
}

// Button, UIButton
struct Demo: Codable, Identifiable {
    let id = UUID()
    let title: String
    let view: String
    
    private enum CodingKeys: String, CodingKey {
        case title, view
    }
}
