//
//  SpriteKit_SKScene_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 21/03/2025.
//

import SwiftUI
import SpriteKit

struct SpriteKit_XcodeTemplate_DemoView: View {
    
    @State private var showInfo = false
    @State private var subtitle: String?
    @State private var customizeAction: (() -> Void)? = nil
    
    var gameScene: SpriteKit_XcodeTemplate_GameScene {
        let scene = SpriteKit_XcodeTemplate_GameScene()
        scene.scaleMode = .aspectFill
//        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.size = .zero
        return scene
    }
    
    var body: some View {

        SpriteView(
            scene: gameScene,
            debugOptions: [.showsFPS, .showsNodeCount, .showsPhysics]
        )
//        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
        .ignoresSafeArea()
        .toolbar {
            
            // NOTE: iOS only, centers subtitle in navigation bar.
            #if os(iOS)
            ToolbarItem(placement: .principal) {
                subtitle.map {
                    Text($0)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel($0)
                }
            }
            #endif
            
            // NOTE: Show demo information.
            #if os(macOS)
            ToolbarItemGroup(placement: .automatic) {
                
                if let customizeAction = customizeAction {
                    Button { customizeAction() } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Customize Settings")
                    .accessibilityHint("Opens customization options")
                }
                
                NavigationLink(destination: {
                    InfoView(fileName: "SpriteKit_XcodeTemplate_Demo", fileType: "md")
                }, label: {
                    Image(systemName: "info.circle")
                })
                .accessibilityLabel("Show Information")
                .accessibilityHint("Opens the info sheet with details about the demo.")
                .accessibilityValue(showInfo ? "Information sheet is open" : "Information sheet is closed")
            }
            
            #elseif os(iOS)
            ToolbarItemGroup(placement: .topBarTrailing) {
                
                if let customizeAction = customizeAction {
                    Button { customizeAction() } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Customize Settings")
                    .accessibilityHint("Opens customization options")
                }
                
                Button { showInfo.toggle() } label: {
                    Image(systemName: "info.circle")
                }
                .accessibilityLabel("Show Information")
                .accessibilityHint("Opens the info sheet with details about the demo.")
                .accessibilityValue(showInfo ? "Information sheet is open" : "Information sheet is closed")
            }
            #endif
        }
        .sheet(isPresented: $showInfo) {
            InfoView(fileName: "SpriteKit_XcodeTemplate_Demo", fileType: "md")
                .presentationSizing(.page)
        }
        .navigationTitle("SpriteKit Demo")
        .accessibilityLabel("SpriteKit Demo")
    }
}

#Preview {
    NavigationStack {
        SpriteKit_XcodeTemplate_DemoView()
    }
}
