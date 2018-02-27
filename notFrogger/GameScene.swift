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
    
    
    override func didMove(to view: SKView) {
        
        makeBackground()
        makeBoard(rows: 3, cols: 3)
       
        makePlayer()
        
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
        let box = SKSpriteNode(color: color, size: size)
        
        scene?.addChild(box)
        
        box.position.x = screenW / 2
        box.position.y = screenH / 2
    }
    
    // make cars
    
    
    func makeBoard(rows: Int, cols: Int) {
        let screenW = size.width
        let screenH = size.height
        
        // make stripe
        for i in -1 ... 1 {
            let stripe = makeStripe(width: screenW, height: 60)
            addChild(stripe)
            stripe.position.x = screenW / 2
            stripe.position.y = screenH / 2 + (65 * CGFloat(i))
        }
        
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
    
}
