//
//  Car.swift
//  notFrogger
//
//  Created by Phyllis Wong on 3/8/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import SpriteKit

enum Direction {
    case up, down
    
    // Pick a random direction.
    static func random() -> Direction {
        // pick and return a new value
        let randomInt = arc4random_uniform(2)
        
        switch randomInt {
        case 0:
            return .up
        case 1:
            return .down
        default:
            return .up
        }
    }
}

/// The objects that will be traveling towards the player with extreme malice.
class Car: SKSpriteNode {
    /// Initialize a SKSpriteNode and place it at given spawn point.
    /// - Parameters:
    ///   - spawn: The point at which the node will be placed in the GameScene.
    init(spawn: CGPoint) {
        super.init(texture: nil, color: .black, size: CGSize(width: 40, height: 40))
        position = spawn
        name = "car"
        setupCarPhysics()
    }
    
    
    func setupCarPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Car
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
