//
//  Player.swift
//  notFrogger
//
//  Created by Phyllis Wong on 3/1/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import SpriteKit

// Tracking touch for use with player movement
enum Direction {
    case left, right, up, down
}




class Player: SKSpriteNode {
    
    // Chopstick objects
    var player: Player!
    
    // Player Move direction
    var direction: Direction = .left {
        didSet {
            if direction == .left {
                self.position.x += 65
                
            } else if direction == .right {
                self.position.x -= 65
                
            } else if direction == .up {
                self.position.y += 65
                
            } else {
                self.position.y -= 65
            }
        }
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
