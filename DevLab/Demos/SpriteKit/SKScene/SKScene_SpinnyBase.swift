//
//  SKScene_SpinnyBase.swift
//  DevLab
//
//  Created by Michael Borgmann on 24/03/2025.
//

#if os(iOS)

import SpriteKit

class SKScene_SpinnyBase: SKScene {
    
    var spinnyNode: SKShapeNode? {
        
        let w = (self.size.width + self.size.height) * 0.05
        
        let node = SKShapeNode(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        node.lineWidth = 4.0
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        node.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                    SKAction.fadeOut(withDuration: 10),
                                    SKAction.removeFromParent()]))
        
        node.isAccessibilityElement = true
        node.accessibilityLabel = "Spinning shape"
        node.accessibilityTraits = .adjustable
        
        return node
    }
    
    func makeSpinny(at pos: CGPoint, color: SKColor) {
        if let spinny = self.spinnyNode?.copy() as! SKShapeNode? {
            spinny.position = pos
            spinny.strokeColor = color
            self.addChild(spinny)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.green)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.blue)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.red)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.makeSpinny(at: t.location(in: self), color: SKColor.red)
        }
    }
}

#endif
