//
//  Terrain.swift
//  AltoClone
//
//  Created by Ann Michélsen on 17/06/16.
//  Copyright © 2016 Ann Michélsen. All rights reserved.
//

import Foundation
import SpriteKit

let maxSlopeKeyPoints: Int = 1000

class Terrain : SKShapeNode {
    
    let winSize = CGRect(x: 0, y: 0, width: 667, height: 375) //TODO fix this!
    
    var slopeKeyPoints: [CGPoint] = [CGPoint](count: maxSlopeKeyPoints, repeatedValue: CGPoint(x: -1,y: -1))
    
    let scrollSpeed: CGFloat = 100
    
    var fromKeyPointI: Int  = 0
    var toKeyPointI: Int  = 0
    var prevFromKeyPointI: Int = -1
    var prevToKeyPointI: Int = -1
    
    override init() {
        super.init()
        
        generateSlope()
        resetHillVertices()
        draw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateSlope(){
        
        let minDX: CGFloat = winSize.width/4
        let minDY: CGFloat = 50
        let rangeDX: Int = 150
        let rangeDY: Int = 300
        
        var x: CGFloat = 160
        var y:CGFloat = winSize.height/2
        
        //TODO make better
        for i in 0..<maxSlopeKeyPoints {
            slopeKeyPoints[i] = CGPoint(x: x, y: y)
            x += CGFloat(arc4random_uniform(UInt32(rangeDX))) + minDX
            y -= CGFloat(arc4random_uniform(UInt32(rangeDY))) + minDY//CGFloat(arc4random_uniform(UInt32(rangeDY))) + minDY
        }
    }
    
    let slopeSegmentWidth:Float = 10
    
    func draw(){
        if prevFromKeyPointI != fromKeyPointI && toKeyPointI != prevToKeyPointI {
            //  for i in max(fromKeyPointI, 1)..<toKeyPointI {
            let line: SKShapeNode = SKShapeNode()
            let pathToDraw:CGMutablePathRef = CGPathCreateMutable()
            CGPathMoveToPoint(pathToDraw, nil, -5, 157);

            
            // CGPathAddLineToPoint(pathToDraw, nil, slopeKeyPoints[0].x, slopeKeyPoints[0].y)
            // CGPathAddLineToPoint(pathToDraw, nil, 0, slopeKeyPoints[0].y)
            
            CGPathAddCurveToPoint(pathToDraw, nil, 190, 210, 200, 70, 303, 125); // Old Code
            CGPathAddQuadCurveToPoint(pathToDraw, nil, 340, 150, 350, 150);
            CGPathAddQuadCurveToPoint(pathToDraw, nil, 380, 155, 410, 145);
            CGPathAddCurveToPoint(pathToDraw, nil, 500, 100, 540, 190, 580, 165);
            CGPathAddLineToPoint(pathToDraw, nil, 580, 0);
            CGPathAddLineToPoint(pathToDraw, nil, 0, 0);
            CGPathCloseSubpath(pathToDraw);
            
            
            line.path = pathToDraw
            line.fillColor = SKColor.whiteColor()
            line.setTiledFillTexture("gradient.jpg", tileSize: CGSize(width: 600, height: 1500))
            
            line.physicsBody = SKPhysicsBody(edgeChainFromPath: pathToDraw)
            
            line.physicsBody?.affectedByGravity = false
            line.physicsBody?.categoryBitMask = 1
            line.physicsBody?.collisionBitMask = 2
            line.physicsBody?.dynamic = false
            line.physicsBody?.allowsRotation = false

            addChild(line)
            
        }
    }
    
    func scrollTerrain(delta: CFTimeInterval ){
        //offsetX = newOffsetX
        // self.position.x -= (scrollSpeed-5) * CGFloat(delta)
        // self.position.y += scrollSpeed * CGFloat(delta)
        
        //resetHillVertices()
        // draw()
    }
    
    func resetHillVertices() { //TODO fix this
        while slopeKeyPoints[fromKeyPointI+1].x - 200 < -self.position.x - winSize.width/8{
            fromKeyPointI += 1
        }
        while slopeKeyPoints[toKeyPointI+1].x - 200 < -self.position.x + winSize.width*12/8 {
            toKeyPointI += 1
            
            print(toKeyPointI)
        }
    }
}









