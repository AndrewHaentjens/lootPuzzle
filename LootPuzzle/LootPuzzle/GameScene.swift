//
//  GameScene.swift
//  LootPuzzle
//
//  Created by Andrew Haentjens on 12/12/2017.
//  Copyright © 2017 Andrew Haentjens. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let indicatorCategory: UInt32 = 0x1 << 1
    let targetCategory: UInt32 = 0x1 << 0
    
    let oneCompleteTurn = CGFloat.pi * 2
    let triangleLength: CGFloat = 20.0
    let margin: CGFloat = 16.0
    
    let invisibleParent = SKSpriteNode()
    
    var tap = UITapGestureRecognizer()
    
    var target1 = SKShapeNode()
    var target2 = SKShapeNode()
    var target3 = SKShapeNode()
    var target4 = SKShapeNode()
    
    var madeContact: Bool = false
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        // Set Tap
        tap.addTarget(self, action: #selector(didTap(_:)))
        self.view?.addGestureRecognizer(tap)
        
        // Set Layout
        setLayout()
        
        // create main circle
        let centerPoint =  CGPoint(x: self.frame.midX, y: self.frame.midY)
        let lock = createCircle(position: centerPoint)
        addChild(lock)
        
        let lockRadius = lock.frame.width / 2
        
        invisibleParent.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(invisibleParent)
        
        // create targets
        // TODO: user pythagoras to determine the distance to edge => calculate x- and y-coordinates
        let target1Center = CGPoint(x: centerPoint.x - lockRadius, y: centerPoint.y)
        target1 = createCircle(position: target1Center, radius: 10.0)
        addChild(target1)
        
        let target2Center = CGPoint(x: centerPoint.x, y: centerPoint.y + lockRadius)
        target2 = createCircle(position: target2Center, radius: 10.0)
        addChild(target2)
        
        let target3Center = CGPoint(x: centerPoint.x + lockRadius, y: centerPoint.y)
        target3 = createCircle(position: target3Center, radius: 10.0)
        addChild(target3)
        
        let target4Center = CGPoint(x: centerPoint.x, y: centerPoint.y - lockRadius)
        target4 = createCircle(position: target4Center, radius: 10.0)
        addChild(target4)
        
        let target1PhysicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        target1PhysicsBody.categoryBitMask = targetCategory
        target1PhysicsBody.collisionBitMask = 0
        target1PhysicsBody.contactTestBitMask = indicatorCategory
        target1PhysicsBody.pinned = true
        target1PhysicsBody.allowsRotation = false
        
        let target2PhysicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        target2PhysicsBody.categoryBitMask = targetCategory
        target2PhysicsBody.collisionBitMask = 0
        target2PhysicsBody.contactTestBitMask = indicatorCategory
        target2PhysicsBody.pinned = true
        target2PhysicsBody.allowsRotation = false
        
        let target3PhysicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        target3PhysicsBody.categoryBitMask = targetCategory
        target3PhysicsBody.collisionBitMask = 0
        target3PhysicsBody.contactTestBitMask = indicatorCategory
        target3PhysicsBody.pinned = true
        target3PhysicsBody.allowsRotation = false
        
        let target4PhysicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        target4PhysicsBody.categoryBitMask = targetCategory
        target4PhysicsBody.collisionBitMask = 0
        target4PhysicsBody.contactTestBitMask = indicatorCategory
        target4PhysicsBody.pinned = true
        target4PhysicsBody.allowsRotation = false
        
        let invisibleParentPhysicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        invisibleParentPhysicsBody.pinned = true
        
        let indicatorPhysicsBody = SKPhysicsBody(circleOfRadius: 20.0)
        indicatorPhysicsBody.categoryBitMask = indicatorCategory
        indicatorPhysicsBody.collisionBitMask = 0
        indicatorPhysicsBody.contactTestBitMask = targetCategory
        //indicatorPhysicsBody.pinned = true
        //indicatorPhysicsBody.allowsRotation = false
        
        target1.physicsBody = target1PhysicsBody
        target2.physicsBody = target2PhysicsBody
        target3.physicsBody = target3PhysicsBody
        target4.physicsBody = target4PhysicsBody
        
        invisibleParent.physicsBody = invisibleParentPhysicsBody
        
        // create indicator (basically the triangle)
        let indicator = createEquilateralTriangle()
        indicator.physicsBody = indicatorPhysicsBody
        indicator.zRotation = CGFloat.pi / 2 // set original rotation so that the corner points inwards towards the center of the circle
        indicator.position.x = (lock.frame.width / 2) + margin // set the offet to center of circle minus the radius and a margin
        
        invisibleParent.addChild(indicator)
        
        let pinJoint = SKPhysicsJointPin.joint(withBodyA: invisibleParent.physicsBody!,
                                               bodyB: indicator.physicsBody!,
                                               anchor: invisibleParent.position)
        scene?.physicsWorld.add(pinJoint)
        scene?.physicsWorld.gravity = .zero
        
        runRotationFor(node: invisibleParent, duration: 2)
        
    }
}

// MARK: private functions

extension GameScene {
    
    // MARK: - General
    
    private func setLayout() {
        self.backgroundColor = SKColor.white
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        if madeContact {
            
        }
    }
    
    // MARK: - Create figures
    
    /**
        Creates a simple circle. Orange with a black border.
     */
    private func createCircle(position: CGPoint, radius: CGFloat = 100.0, fillColor: UIColor = .orange, strokeColor: UIColor = .black) -> SKShapeNode {
        
        let circle = SKShapeNode(circleOfRadius: radius)
        
        circle.position = position
        circle.strokeColor = strokeColor
        circle.glowWidth = 1.0
        circle.fillColor = fillColor
        
        return circle
    }
    
    /**
        Creates a triangle with equal sides. Orange with a black border.
     */
    private func createEquilateralTriangle() -> SKShapeNode {
        
        // create an equal side triangle
        let cSideSqrd = (triangleLength * triangleLength) - ((triangleLength / 2) * (triangleLength / 2)) // C^2 - A^2
        let cSide = cSideSqrd.squareRoot()
        
        var points = [
            CGPoint(x: triangleLength / 2.0, y: -cSide / 2.0),   // right under point
            CGPoint(x: -triangleLength / 2.0, y: -cSide / 2.0),  // left under point
            CGPoint(x: 0.0, y: cSide / 2.0),                              // top point
            CGPoint(x: triangleLength / 2.0, y: -cSide / 2.0)    // right under point again
        ]
        
        let triangle = SKShapeNode(points: &points, count: points.count)
        
        triangle.fillColor = .red
        triangle.strokeColor = .black
        triangle.glowWidth = 1.0
        
        return triangle
        
    }
    
    // MARK: - Animations
    
    /**
        Create the rotating animation
     */
    private func runRotationFor(node: SKNode, isInfinite: Bool = true, duration: TimeInterval = 0.3) {
        
        let rotateAction = SKAction.rotate(byAngle: -oneCompleteTurn, duration: duration)
        
        if !isInfinite {
            node.run(rotateAction)
            return
        }
        
        let repeatedRotateAction = SKAction.repeatForever(rotateAction)
        node.run(repeatedRotateAction)
        
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        madeContact = true
        
        if contact.bodyA.node == target1 || contact.bodyB.node == target1 {
            target1.fillColor = .green
        }
        
        if contact.bodyA.node == target2 || contact.bodyB.node == target2 {
            target2.fillColor = .green
        }
        
        if contact.bodyA.node == target3 || contact.bodyB.node == target3 {
            target3.fillColor = .green
        }
        
        
        if contact.bodyA.node == target4 || contact.bodyB.node == target4 {
            target4.fillColor = .green
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        madeContact = false
        
        target1.fillColor = .orange
        target2.fillColor = .orange
        target3.fillColor = .orange
        target4.fillColor = .orange
    }
    
}
