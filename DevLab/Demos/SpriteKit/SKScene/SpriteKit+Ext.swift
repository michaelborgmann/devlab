//
//  SpriteKit+Ext.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/04/2025.
//

import SpriteKit

extension SKSceneScaleMode: @retroactive CaseIterable {
    public static var allCases: [SKSceneScaleMode] {
        return [.fill, .aspectFill, .aspectFit, .resizeFill]
    }
    
    var displayName: String {
        switch self {
        case .fill: return "Fill"
        case .aspectFill: return "Aspect Fill"
        case .aspectFit: return "Aspect Fit"
        case .resizeFill: return "Resize Fill"
        @unknown default: return "Unknown"
        }
    }
}
