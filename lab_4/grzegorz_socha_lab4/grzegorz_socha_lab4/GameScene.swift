//
//  GameScene.swift
//  grzegorz_socha_lab4
//
//  Created by Grzegorz Socha on 16/05/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var rectangles = [SKSpriteNode]()
    
    override func didMove(to view: SKView) {
        
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
        let addButton = SKLabelNode(text: "Add")
        addButton.position = CGPoint(x: -300, y: -570)
        addButton.name = "addButton"
        addChild(addButton)
        
        let removeButton = SKLabelNode(text: "Remove")
        removeButton.position = CGPoint(x: 290, y: -570)
        removeButton.name = "removeButton"
        addChild(removeButton)
        
        let stackNode = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 200, height: 200))
        stackNode.position = CGPoint(x: 0, y: 510)
        stackNode.name = "stackNode"
        addChild(stackNode)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let touchedNode = atPoint(touchLocation)
        
        if touchedNode.name == "addButton" {
            addRectangle()
        } else if touchedNode.name == "removeButton" {
            removeRectangle()
        }
    }
    
    func addRectangle() {
        guard let stackNode = childNode(withName: "stackNode") as? SKSpriteNode else {
            return
        }
        
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        
        let newRectangle = SKSpriteNode(color: SKColor(red: r, green: g, blue: b, alpha: 1.0), size: CGSize(width: 600, height: 100))
        let stackHeight = stackNode.frame.height
        newRectangle.position = CGPoint(x: stackNode.position.x, y: stackHeight / 2 - CGFloat(rectangles.count * 100))
        newRectangle.name = "newRectangle"
        stackNode.addChild(newRectangle)
        
        newRectangle.alpha = 0.0
        newRectangle.setScale(0.1)
        
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.3)
        let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
        let groupAction = SKAction.group([scaleAction, fadeInAction])
        newRectangle.run(groupAction)
                                    
        rectangles.append(newRectangle)
    }
    
    func removeRectangle() {
        guard let stackNode = childNode(withName: "stackNode") as? SKSpriteNode, let topRectangle = rectangles.first else {
            return
        }
        
        let scaleAction = SKAction.scale(to: 0.1, duration: 0.2)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
        let groupAction = SKAction.group([scaleAction, fadeOutAction])
        let removeAction = SKAction.removeFromParent()
        let removeSequence = SKAction.sequence([groupAction, removeAction])
        topRectangle.run(removeSequence)
        rectangles.removeFirst()
        
        for index in 0..<rectangles.count {
            let rectangle = rectangles[index]
            let moveAction = SKAction.moveTo(y: stackNode.frame.height / 2 - CGFloat(index * 100), duration: 0.3)
            rectangle.run(moveAction)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
