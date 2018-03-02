//
//  GameScene.swift
//  notFrogger
//
//  Created by Phyllis Wong on 2/22/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    let stripe: SKSpriteNode? = nil
    var player: Player! = nil
    
    override func didMove(to view: SKView) {
        makeBackground()
        makeBoard(rows: 3, cols: 3)
        makePlayer()
        makeStartingPoints()
        run(SKAction.repeatForever(
            SKAction.sequence([ SKAction.run(makeCar), SKAction.wait(forDuration: 1.0) ])
        ))
        
        
    }
    
    func makeStripe(width: CGFloat, height: CGFloat) -> SKSpriteNode {
        let color = UIColor(white: 1, alpha: 0.2)
        let size = CGSize(width: width, height: height)
        let stripe = SKSpriteNode(color: color, size: size)
        
        return stripe
    }
    
    func makePlayer() {
        let screenW = self.size.width
        let screenH = self.size.height
        
        let color = UIColor.red
        let size = CGSize(width: 40, height: 40)
        player = Player(color: color, size: size)
        
        addChild(player)
        
        player.position.x = screenW / 2
        player.position.y = screenH / 2
    }
    
    func movePlayer(player: SKSpriteNode) {
        // Player Move direction
        var direction: Direction = .left {
            didSet {
                if direction == .left {
                    player.position.x += 65
                    
                } else if direction == .right {
                    player.position.x -= 65
                    
                } else if direction == .up {
                    player.position.y += 65
                    
                } else {
                    player.position.y -= 65
                }
            }
        }
    }
    
    
    // Start spawning cars.
   
    
    
    // make cars
    func makeCar() {
        // Makes a black square
        let startPoint = randomizeStart()
        let endPoint: CGPoint!
        
        let screenW = self.size.width
        let screenH = self.size.height
        
        // let endPoint = CGPoint(x: screenW, y: screenH / 2)
        if startPoint.x == -50 {
            // The car drives right
            let x = screenW
            let y = startPoint.y
            endPoint = CGPoint(x: x, y: y)
            
        } else if startPoint.y == -50 {
            // The car drives up
            let x = startPoint.x
            let y = screenH
            endPoint = CGPoint(x: x, y: y)
            
        } else if startPoint.x == screenW {
            // The car drives left
            let x = CGFloat(0)
            let y = startPoint.y
            endPoint = CGPoint(x: x, y: y)
            
        } else {
            // The car drives down
            let x = startPoint.x
            let y = CGFloat(-50)
            endPoint = CGPoint(x: x, y: y)
        }

        // black boxes that move across the screen
        let color = UIColor.black
        let size = CGSize(width: 40, height: 40)
        let car = SKSpriteNode(color: color, size: size)
        
        addChild(car)
        
        car.position = startPoint
        moveCar(car: car, endPoint: endPoint)
    }
    
    // move the car across the screen
    func moveCar(car: SKSpriteNode, endPoint: CGPoint) {
        let carPathAction = SKAction.move(to: endPoint, duration: 3)
        let car = car
        let removeAction = SKAction.run(car.removeFromParent)
        let moveAndRemoveSequence = SKAction.sequence([carPathAction, removeAction])
        car.run(moveAndRemoveSequence)
    }
    
    // starting points and ending points
    
    var startPoints = [CGPoint]()
    
    func makeStartingPoints() {
        // use loop to append to startpoints array
        
        let screenW = size.width
        let screenH = size.height
        
        for i in -1 ... 1 {

            // create all the leftRow start points
            let x = CGFloat(-50)
            let y = CGFloat(screenH / 2) + (65 * CGFloat(i))
            let point = CGPoint(x: x, y: y)
            startPoints.append(point)
        }
        
        for j in -1 ... 1 {
            
            // create all the bottomColumn start points
            let x = CGFloat(screenW / 2) + (65 * CGFloat(j))
            let y = CGFloat(-50)
            let point = CGPoint(x: x, y: y)
            
            startPoints.append(point)
        }
        
        for k in -1 ... 1 {
            // create all the rightRow start points
            let x = CGFloat(screenW + 50)
            let y = CGFloat(screenH / 2) + (65 * CGFloat(k))
            let point = CGPoint(x: x, y: y)
            
            startPoints.append(point)
        }
        for l in -1 ... 1 {
            // create all the topColumn start points
            let x = CGFloat(screenW / 2) + (65 * CGFloat(l))
            let y = CGFloat(screenH + 50)
            let point = CGPoint(x: x, y: y)
            
            startPoints.append(point)
        }
        print(startPoints)
    }
    
    // randomize the starting point
    func randomizeStart() -> CGPoint {
        let start = startPoints[Int(arc4random_uniform(UInt32(startPoints.count)))]
        print(start)
        return start
    }
    
    func makeBoard(rows: Int, cols: Int) {
        let screenW = size.width
        let screenH = size.height
        
        // make horizontal stripes
        for i in -1 ... 1 {
            let stripe = makeStripe(width: screenW, height: 60)
            addChild(stripe)
            stripe.position.x = screenW / 2
            stripe.position.y = screenH / 2 + (65 * CGFloat(i))
        }
        
        // make vertical stripes
        for j in -1 ... 1 {
            let stripe = makeStripe(width: 60, height: screenH)
            addChild(stripe)
            stripe.position.y = screenH / 2
            stripe.position.x = screenW / 2 + (65 * CGFloat(j))
        }
    }
    
    func makeBackground() {
        
        let brown = UIColor(red: 139/255, green: 69/255, blue: 19/255, alpha: 0.5)
        let screenW = self.size.width
        let screenH = self.size.height
        let size = CGSize(width: screenW, height: screenH)
        
        let background = SKSpriteNode(color: brown, size: size)
        
        background.position.x = screenW / 2
        background.position.y = screenH / 2
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        // Get touch position in scene
        let location = touch!.location(in: self)
        
        // Check if touch was on left/right hand side of screen
        if location.x > size.width / 2 {
            player!.direction = .right
        } else {
            // character.side = .left
        }
        
    }
    
}
