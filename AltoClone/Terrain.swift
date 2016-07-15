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
        
        //generateSlope()
        //resetHillVertices()
        //draw()
        //testTer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    func tinyWingsTest(){
//        
//        let p0 = slopeKeyPoints[i-1]
//        let p1 = slopeKeyPoints[i]
//        let hSegments = floorf((Float(p1.x)-Float(p0.x))/5)
//        let dx = (Float(p1.x)-Float(p0.x))/hSegments
//        let da = Float(M_PI)/hSegments
//        let ymid = (p0.y + p1.y) / 2
//        let ampl = (p0.y - p1.y) / 2
//        
//        
//        pt0 = p0
//        
//        for j in 0...Int(hSegments)+1 {
//            pt1.x = p0.x + (CGFloat(j)*CGFloat(dx))
//            pt1.y = ymid + ampl * CGFloat(cosf(Float(da)*Float(j)));
//            //pathToDraw.moveToPoint(pt0)
//            
//            pathToDraw.addLineToPoint(pt1)
//            
//            //CGPathAddLineToPoint(pathToDraw, nil, pt0.x, pt0.y)
//            //CGPathAddLineToPoint(pathToDraw, nil, pt1.x, pt1.y)
//            pt0 = pt1
//        }
//    }
    
    
    
    func generateSlope(){
        
        let minDX: CGFloat = 10
        let minDY: CGFloat = 10
        let rangeDX: Int = 100
        let rangeDY: Int = 100
        
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
        var pt0:CGPoint = CGPoint(x: 0, y: 0)
        var pt1:CGPoint  = CGPoint(x: 0, y: 0)
        
        if prevFromKeyPointI != fromKeyPointI && toKeyPointI != prevToKeyPointI {
            let line: SKShapeNode = SKShapeNode()
            let pathToDraw = CGPathCreateMutable()
            
            //let newPath = UIBezierPath()
            //newPath.addCurveToPoint(<#T##endPoint: CGPoint##CGPoint#>, controlPoint1: <#T##CGPoint#>, controlPoint2: <#T##CGPoint#>)
            
            CGPathMoveToPoint(pathToDraw, nil, 0, 0);
            
            
            //CGPathMoveToPoint(pathToDraw, nil, 0, 150);
            //pathToDraw.moveToPoint(slopeKeyPoints[0])
            //            for i in 1...5 {
            //
            //                let p0 = slopeKeyPoints[i-1]
            //                let p1 = slopeKeyPoints[i]
            //                let hSegments = floorf((Float(p1.x)-Float(p0.x))/5)
            //                let dx = (Float(p1.x)-Float(p0.x))/hSegments
            //                let da = Float(M_PI)/hSegments
            //                let ymid = (p0.y + p1.y) / 2
            //                let ampl = (p0.y - p1.y) / 2
            //
            //
            //                pt0 = p0
            //
            //                for j in 0...Int(hSegments)+1 {
            //                    pt1.x = p0.x + (CGFloat(j)*CGFloat(dx))
            //                    pt1.y = ymid + ampl * CGFloat(cosf(Float(da)*Float(j)));
            //                    //pathToDraw.moveToPoint(pt0)
            //
            //                    pathToDraw.addLineToPoint(pt1)
            //
            //                    //CGPathAddLineToPoint(pathToDraw, nil, pt0.x, pt0.y)
            //                    //CGPathAddLineToPoint(pathToDraw, nil, pt1.x, pt1.y)
            //                    pt0 = pt1
            //                }
            //
            ////
            ////            pathToDraw.addLineToPoint(slopeKeyPoints[0])
            ////            pathToDraw.addLineToPoint(slopeKeyPoints[1])
            ////                pathToDraw.addLineToPoint(slopeKeyPoints[2])
            ////                pathToDraw.addLineToPoint(slopeKeyPoints[3])
            ////                pathToDraw.addLineToPoint(slopeKeyPoints[4])
            //
            //
            //
            ////                CGPathAddLineToPoint(pathToDraw, nil, slopeKeyPoints[0].x, slopeKeyPoints[0].y)
            ////                CGPathAddLineToPoint(pathToDraw, nil, slopeKeyPoints[1].x, slopeKeyPoints[1].y)
            ////                CGPathAddLineToPoint(pathToDraw, nil, slopeKeyPoints[2].x, slopeKeyPoints[2].y)
            ////                CGPathAddLineToPoint(pathToDraw, nil, slopeKeyPoints[3].x, slopeKeyPoints[3].y)
            ////                CGPathAddLineToPoint(pathToDraw, nil, slopeKeyPoints[4].x, slopeKeyPoints[4].y)
            //
            //                //CGPathAddLineToPoint(pathToDraw, nil, 0, slopeKeyPoints[0].y)
            
            CGPathAddCurveToPoint(pathToDraw, nil, 190, 210, 200, 70, 303, 125); // Old Code
            CGPathAddQuadCurveToPoint(pathToDraw, nil, 340, 150, 350, 150);
            CGPathAddQuadCurveToPoint(pathToDraw, nil, 380, 155, 410, 145);
            
            CGPathAddCurveToPoint(pathToDraw, nil, 500, 100, 540, 190, 580, 165);
            CGPathAddLineToPoint(pathToDraw, nil, 580, frame.size.width);
            CGPathAddLineToPoint(pathToDraw, nil, -5, frame.size.width);
            CGPathCloseSubpath(pathToDraw);
            
            
            //                 CGPathAddCurveToPoint(pathToDraw, nil, 190, 210, 200, 70, 303, 125);  Old Code
            //                 CGPathAddQuadCurveToPoint(pathToDraw, nil, 340, 150, 350, 150);
            //                 CGPathAddQuadCurveToPoint(pathToDraw, nil, 380, 155, 410, 145);
            //                 CGPathAddCurveToPoint(pathToDraw, nil, 500, 100, 540, 190, 580, 165);
            //
            //
            CGPathAddLineToPoint(pathToDraw, nil, 580, 0);
            CGPathAddLineToPoint(pathToDraw, nil, 0, 0);
            CGPathCloseSubpath(pathToDraw);
            
            
            
            //}
            
            line.path = pathToDraw
            line.fillColor = SKColor.whiteColor()
            //line.setTiledFillTexture("gradient.jpg", tileSize: CGSize(width: 600, height: 1500))
            line.strokeColor = SKColor.redColor()
            
            line.physicsBody = SKPhysicsBody(edgeChainFromPath: pathToDraw)
            
            line.physicsBody?.affectedByGravity = false
            line.physicsBody?.categoryBitMask = 1
            line.physicsBody?.collisionBitMask = 2
            line.physicsBody?.dynamic = false
            line.physicsBody?.allowsRotation = false
            
            addChild(line)
            
        }
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
    
    
    func testTer(){
        let centerY = 300  // find the vertical center
        let steps = 10                // Divide the curve into steps
        let stepX :CGFloat = 100 // find the horizontal step distance
        
        // Make a path
        let path = UIBezierPath()
        // Start in the lower left corner
        path.moveToPoint(CGPoint(x: 0, y: frame.height))
        // Draw a line up to the vertical center
        path.addLineToPoint(CGPoint(x: 0, y: centerY))
        // Loop and draw steps in straingt line segments
        for i in 0...steps {
            let x = CGFloat(i) * stepX
            let y = (sin((Double(i) * 0.18)) * Double(50)) + Double(centerY)
            path.addLineToPoint(CGPoint(x: x, y: CGFloat(y)))
        }
        
        // Draw down to the lower right
        path.addLineToPoint(CGPoint(x: frame.width, y: 0))
        
        //path.addLineToPoint(CGPoint(x: frame.width, y: frame.height))
        // Close the path
        //path.closePath()
        var pathLayer = SKShapeNode()
        pathLayer.path = path.CGPath
        pathLayer.fillColor = UIColor.blueColor()
        pathLayer.strokeColor = UIColor.redColor()
        addChild(pathLayer)
    }
}









