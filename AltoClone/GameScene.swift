//
//  GameScene.swift
//  AltoClone
//
//  Created by Ann Michélsen on 17/06/16.
//  Copyright (c) 2016 Ann Michélsen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var terrain:Terrain?
    
    var lastUpdateTimeInterval: NSTimeInterval = 0

    override func didMoveToView(view: SKView) {
        terrain = Terrain()
        self.addChild(terrain!)
        
        
        //test test
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)

        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        var timeSinceLast: CFTimeInterval = currentTime - self.lastUpdateTimeInterval
        self.lastUpdateTimeInterval = currentTime
        if timeSinceLast > 1 {
            timeSinceLast = 1.0 / 60.0
            self.lastUpdateTimeInterval = currentTime
        }
        

        terrain?.scrollTerrain(timeSinceLast)
    }
}
