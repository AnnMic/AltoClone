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

    let kMaxHillKeyPoints = 10
    var line: SKShapeNode!
    var bezier: SKShapeNode!

    var fromPositionIndex = -1
    var toPositionIndex = -1
    
    let kHillSegmentWidth: CGFloat = 5

    override init() {
        super.init()

        
        line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 667, height: 375))
        line.strokeColor = UIColor.blueColor()
        line.fillColor = UIColor.clearColor()
       // addChild(line)
        
        bezier = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 667, height: 375))
        bezier.strokeColor = UIColor.redColor()
        //bezier.fillColor = UIColor.lightGrayColor()
        addChild(bezier)
        
       // setScale(0.5)

        

        
        
        generateHillKeyPoints()
        betterHillGeneration()
        draw()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func generateHillKeyPoints(){
        var x : CGFloat = 0
        var y : CGFloat = line.frame.height/2 //TODO frame could be 0
        hillKeyPoints.append(CGPoint(x: 0, y: 0))
        
        for _ in 0..<kMaxHillKeyPoints {
            x += 200
            y = CGFloat(arc4random_uniform(UInt32(line.frame.height * 0.75)))
            hillKeyPoints.append(CGPoint(x: x, y: y))
        }
    }
    
    func betterHillGeneration() {
        let minDX:CGFloat = 200
        let minDY:CGFloat = 60
        let rangeDX:Int32 = 80
        let rangeDY:Int32 = 200

        var x: CGFloat = -minDX
        var y: CGFloat = line.frame.height/2
        
        var dy: CGFloat
        var ny: CGFloat = 0
        var sign: CGFloat = 1 // +1 - going up, -1 - going  down
        
        let paddingTop:CGFloat = 20
        
        for i in 0..<kMaxHillKeyPoints {
            
            if i == 0 { //Start in the middle of the screen
                x = 0
                y = line.frame.height * 0.75
            }else{
                x += CGFloat(rand()%rangeDX) + minDX
                y -= 50
                while true {
                    dy = CGFloat(rand()%rangeDY) + minDY
                    ny = y + dy*sign
                    
                    if ny<line.frame.height-paddingTop {
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
        let path = UIBezierPath()
        path.moveToPoint(hillKeyPoints[0])
        for i in 1...kMaxHillKeyPoints {
            //for i in max(fromPositionIndex, 1)...toPositionIndex {
            path.addLineToPoint(hillKeyPoints[i])
        }
        line.path = path.CGPath
        
        
        let pathBezier = UIBezierPath()
        pathBezier.moveToPoint(newHillKeyPoints[0])
        
        var pt0: CGPoint = CGPoint(x: 0, y: 0)
        var pt1: CGPoint = CGPoint(x: 0, y: 0)
        
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
        bezier.physicsBody?.allowsRotation = false
        
    }
    
    func resetHillVertices(){
        
    }
}

