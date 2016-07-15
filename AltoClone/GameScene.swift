//
//  GameScene.swift
//  AltoClone
//
//  Created by Ann Michélsen on 17/06/16.
//  Copyright (c) 2016 Ann Michélsen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var terrain:Terrain?
    
    var lastUpdateTimeInterval: NSTimeInterval = 0

    var circle: SKShapeNode!

    override func didMoveToView(view: SKView) {
        //terrain = Terrain()
        //self.addChild(terrain!)
        self.addChild(TerrainTinyWings())
        
        
        physicsWorld.contactDelegate = self
        view.showsPhysics = true
        
        circle = SKShapeNode(circleOfRadius: 20)
        circle.physicsBody = SKPhysicsBody(rectangleOfSize: circle.frame.size)
        circle.fillColor = SKColor.blackColor()
        circle.physicsBody?.affectedByGravity = true
        circle.physicsBody?.dynamic = true
        circle.physicsBody?.contactTestBitMask = 1
        circle.position = CGPoint(x: 100, y: size.height)
        addChild(circle)
//        circle.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(1, duration: 3)))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        var timeSinceLast: CFTimeInterval = currentTime - self.lastUpdateTimeInterval
        self.lastUpdateTimeInterval = currentTime
        if timeSinceLast > 1 {
            timeSinceLast = 1.0 / 60.0
            self.lastUpdateTimeInterval = currentTime
        }
        

    }
    
 /*   func didBeginContact(contact: SKPhysicsContact) {
        print("contact")
        
        ball.physicsBody = nil
        let test = ball
        var pos = convertPoint(ball.position, toNode: circle)
        pos = CGPoint(x: pos.x-10, y: pos.y-10)
        ball.moveToParent(circle)
        test.position = pos
        
    }*/
}
