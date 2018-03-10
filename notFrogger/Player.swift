//
//  Player.swift
//  notFrogger
//
//  Created by Phyllis Wong on 3/1/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import SpriteKit

// Tracking touch for use with player movement
enum Move {
    case left, right, up, down
}

class Player: SKSpriteNode {
    
    // Player piece
    var player: Player!
    
    // Player can move these directions
    var move: Move = .left {
        didSet {
            if move == .left {
                self.position.x -= 65
                
            } else if move == .right {
                self.position.x += 65
                
            } else if move == .up {
                self.position.y += 65
                
            } else {
                self.position.y -= 65
            }
        }
    }
    
    init() {
        super.init(texture: nil, color: .red, size: CGSize(width: 40, height: 40))
        self.name = "player"
        setupPlayerPhysics()
    }
    
    
    func setupPlayerPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Car | PhysicsCategory.Coin
    }
    
    // Required to implement for the subclass to work
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    // Required to implement for the subclass to work
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
