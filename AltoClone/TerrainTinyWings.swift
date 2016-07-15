//
//  TerrainTinyWings.swift
//  AltoClone
//
//  Created by Ann Michélsen on 14/07/16.
//  Copyright © 2016 Ann Michélsen. All rights reserved.
//

import Foundation
import SpriteKit

class TerrainTinyWings : SKNode {
    
    var hillKeyPoints: [CGPoint] = []
    var newHillKeyPoints: [CGPoint] = []
    
    let kMaxHillKeyPoints = 15
    var line: SKShapeNode!
    var bezier: SKShapeNode!
    
    var fromPositionIndex = 0
    var toPositionIndex = 1
    
    var fromPositionIndexDrawn = 0
    var toPositionIndexDrawn = 1
    
    let kHillSegmentWidth: CGFloat = 10
    var playerPosX: CGFloat = 0
    
    override init() {
        super.init()
        
        
        //        line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 667, height: 375))
        //
        //        line.strokeColor = UIColor.blueColor()
        //        line.fillColor = UIColor.clearColor()
        //        line.lineWidth = 4
        //        addChild(line)
        
        bezier = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 667, height: 375))
        bezier.position = CGPoint(x: -100,y: 0)
        bezier.zRotation = CGFloat(GLKMathDegreesToRadians(-15))
        
        bezier.strokeColor = UIColor.redColor()
        //bezier.fillColor = UIColor.lightGrayColor()
        bezier.lineWidth = 4
        addChild(bezier)
        
        var test = SKShapeNode(circleOfRadius: 5)
        test.fillColor = UIColor.blueColor()
        test.position = CGPoint(x: 0,y: 0)
        addChild(test)
        //setScale(0.3)
        
        //generateHillKeyPoints()
        betterHillGeneration()
        //resetHillVertices()
        
        draw()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //    func generateHillKeyPoints(){
    //        var x : CGFloat = 0
    //        var y : CGFloat = line.frame.height/2 //TODO frame could be 0
    //        hillKeyPoints.append(CGPoint(x: 0, y: 0))
    //
    //        for _ in 0..<kMaxHillKeyPoints {
    //            x += 200
    //            y = CGFloat(arc4random_uniform(UInt32(line.frame.height * 0.75)))
    //            hillKeyPoints.append(CGPoint(x: x, y: y))
    //        }
    //    }
    //
    func betterHillGeneration() {
        let minDX:CGFloat = 400
        let minDY:CGFloat = 100
        let rangeDX:Int32 = 260
        let rangeDY:Int32 = 150
        
        var x: CGFloat = -minDX
        var y: CGFloat = bezier.frame.height/2
        
        var dy: CGFloat
        var ny: CGFloat = 0
        var sign: CGFloat = 1 // +1 - going up, -1 - going  down
        
        let paddingTop:CGFloat = 20
        
        for i in 0..<kMaxHillKeyPoints {
            
            if i == 0 { //Start in the middle of the screen
                x = 0
                y = bezier.frame.height * 0.75
            }else{
                x += CGFloat(rand()%rangeDX) + minDX
                while true {
                    dy = CGFloat(rand()%rangeDY) + minDY
                    ny = y + dy*sign
                    
                    if ny<bezier.frame.height-paddingTop {
                        break;
                    }
                }
                y = ny
            }
            
            newHillKeyPoints.append(CGPoint(x: x, y: y))
            sign *= -1
        }
    }
    
    func draw(){
        //if (fromPositionIndexDrawn != fromPositionIndex || toPositionIndexDrawn != toPositionIndex) {
            
            //        let path = UIBezierPath()
            //        path.moveToPoint(hillKeyPoints[0])
            //        for i in 1...kMaxHillKeyPoints {
            //            //for i in max(fromPositionIndex, 1)...toPositionIndex {
            //            path.addLineToPoint(hillKeyPoints[i])
            //        }
            //        line.path = path.CGPath
            //
            
            let pathBezier = UIBezierPath()
            pathBezier.moveToPoint(newHillKeyPoints[0])
            
            var pt0: CGPoint = CGPoint(x: 0, y: 0)
            var pt1: CGPoint = CGPoint(x: 0, y: 0)
            
            //for i in max(fromPositionIndex, 1)...toPositionIndex {
                for i in 1..<kMaxHillKeyPoints {
                
                let p0 = newHillKeyPoints[i-1]
                let p1 = newHillKeyPoints[i]
                let hSegments: CGFloat = (p1.x-p0.x)/kHillSegmentWidth
                let dx: CGFloat = (p1.x-p0.x)/hSegments
                let da:CGFloat = CGFloat(M_PI)/hSegments
                let ymid = (p0.y + p1.y) / 2
                let ampl = (p0.y - p1.y) / 2
                
                pt0 = p0
                
                for j in 0...Int(hSegments)+1 {
                    pt1.x = p0.x + CGFloat(j)*dx
                    pt1.y = ymid + ampl * CGFloat(cos(da*CGFloat(j)))
                    pathBezier.addLineToPoint(pt1)
                    
                    pt0 = pt1
                }
            }
            bezier.path = pathBezier.CGPath
            
            bezier.physicsBody = SKPhysicsBody(edgeChainFromPath: pathBezier.CGPath)
            bezier.physicsBody?.affectedByGravity = false
            bezier.physicsBody?.categoryBitMask = 1
            bezier.physicsBody?.dynamic = false
            bezier.physicsBody?.friction = 0.5
            bezier.physicsBody?.allowsRotation = false
            
            toPositionIndexDrawn = toPositionIndex
            fromPositionIndexDrawn = fromPositionIndex
       // }
    }
    
//    func resetHillVertices() { //TODO fix this
//       /* while playerPosX > newHillKeyPoints[fromPositionIndex].x {
//            fromPositionIndex += 1
//            print("FROM \(fromPositionIndex)")
//        }*/
//        while newHillKeyPoints[toPositionIndex].x < playerPosX + bezier.frame.width/2 {
//            toPositionIndex += 1
//            
//            print("to \(toPositionIndex)")
//        }
//    }
    
//    func setPlayerX(playerPosX: CGFloat) {
//        self.playerPosX = playerPosX
//        resetHillVertices()
//        draw()
//    }
}

