//
//  SpriteKit_SKScene_GameScene.swift
//  DevLab
//
//  Created by Michael Borgmann on 22/03/2025.
//

import SpriteKit

class SpriteKit_SKScene_GameScene: SKScene_SpinnyBase {
    
    let viewModel: DemoViewModel
    
    private var imageSpriteNode: SKSpriteNode?
    
    init(viewModel: DemoViewModel) {
        self.viewModel = viewModel
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        updateBackgroundColor()
        updateSubtitle()
        
        // Set the action here to ensure the scene is fully initialized before modifying viewModel.
        viewModel.customizeAction = { [weak self] in
            Task { @MainActor in
                self?.viewModel.showCustomizations.toggle()
            }
        }
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        updateSubtitle() // Update when the scene resizes
    }
    
    func updateBackgroundColor() {
        backgroundColor = SKColor(viewModel.backgroundColor)
    }
    
    func updateSubtitle() {
        Task { @MainActor in
            viewModel.subtitle = "Size: \(Int(size.width))x\(Int(size.height))"
        }
    }
    
    func updateBackgroundImage() {
        
        guard let image = viewModel.selectedImage else {
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
