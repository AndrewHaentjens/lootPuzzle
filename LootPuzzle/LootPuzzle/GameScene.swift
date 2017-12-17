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
    
    let oneCompleteTurn = CGFloat.pi * 2
    let circleRadius: CGFloat = 100.0
    let triangleLength: CGFloat = 20.0
    let margin: CGFloat = 16.0
    
    override func didMove(to view: SKView) {
        // Set Layout
        setLayout()
        
        // create main circle
        let lock = createCircle()
        addChild(lock)
        
        let invisibleParent = SKSpriteNode()
        invisibleParent.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(invisibleParent)
        
        // create indicator (basically the triangle)
        let indicator = createEquilateralTriangle()
        indicator.zRotation = CGFloat.pi / 2 // set original rotation so that the corner points inwards towards the center of the circle
        indicator.position.x = circleRadius + margin // set the offet to center of circle minus the radius and a margin
        invisibleParent.addChild(indicator)
        
        runRotationFor(node: invisibleParent, duration: 2)
        
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

// MARK: private functions

extension GameScene {
    
    // MARK: - General
    
    private func setLayout() {
        self.backgroundColor = SKColor.white
    }
    
    // MARK: - Create figures
    
    /**
        Creates a simple circle. Orange with a black border.
     */
    private func createCircle() -> SKShapeNode {
        
        let circle = SKShapeNode(circleOfRadius: circleRadius)
        
        circle.position = CGPoint(x: frame.midX, y: frame.midY)
        circle.strokeColor = .black
        circle.glowWidth = 1.0
        circle.fillColor = .orange
        
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
