//
//  SpriteKit_SKScene_GameScene.swift
//  DevLab
//
//  Created by Michael Borgmann on 22/03/2025.
//

import SpriteKit

class SpriteKit_SKScene_GameScene: SKScene_SpinnyBase {
    
    let viewModel: DemoViewModel
    let sceneModel: SpriteKit_SKScene_ViewModel
    
    private var imageSpriteNode: SKSpriteNode?
    
    #if os(iOS)
    let screenSize = UIScreen.main.bounds.size
    #elseif os(macOS)
    let screenSize = NSScreen.main?.frame.size ?? CGSize(width: 800, height: 600) // Default size if no screen available
    #endif
    
    init(viewModel: DemoViewModel, sceneModel: SpriteKit_SKScene_ViewModel) {
        self.viewModel = viewModel
        self.sceneModel = sceneModel
        super.init(size: screenSize)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        updateBackgroundColor()
        updateSubtitle()
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        updateSubtitle() // Update when the scene resizes
    }
    
    func updateBackgroundColor() {
        backgroundColor = SKColor(sceneModel.backgroundColor)
    }
    
    func updateSubtitle() {
        Task { @MainActor in
            viewModel.subtitle = "Size: \(Int(size.width))x\(Int(size.height))"
        }
    }
    
    func updateBackgroundImage() {
        
        guard let image = sceneModel.selectedImage else {
            imageSpriteNode?.removeFromParent()
            imageSpriteNode = nil
            return
        }
        
        let texture = SKTexture(image: image)
        
        if let existingNode = imageSpriteNode {
            existingNode.texture = texture
        } else {
            let newNode = SKSpriteNode(texture: texture)
            newNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            addChild(newNode)
            imageSpriteNode = newNode
        }
    }
}
