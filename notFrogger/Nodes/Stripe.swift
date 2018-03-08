//
//  Stripe.swift
//  notFrogger
//
//  Created by Phyllis Wong on 3/7/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import SpriteKit

enum Orientation {
    case horizontal, vertical
}

class Stripe: SKSpriteNode {
    
    var orientation: Orientation!
    
    var top: CGPoint! {
        get {
            switch orientation {
            case .horizontal:
                let xPos = position.x + (size.width / 2)
                return CGPoint(x: xPos, y: position.y)
            case .vertical:
                let yPos = position.y + (size.height / 2)
                return CGPoint(x: position.x, y: yPos)
            default:
                return .zero
            }
        }
    }
    
    var bottom: CGPoint! {
        get {
            switch orientation {
            case .horizontal:
                let xPos = position.x + (size.width / 2)
                return CGPoint(x: -xPos, y: position.y)
            case .vertical:
                let yPos = position.y + (size.height / 2)
                return CGPoint(x: position.x, y: -yPos)
            default:
                 return .zero
            }
        }
    }
    
    /// Intialize a SKSpriteNode with the specified size and orientation.
    ///
    /// Parameters:
    ///   - size: The dimensions of the stripe.
    ///   - orientation: The orientaiton of the stripe on a Board.
    init(size: CGSize, orientation: Orientation) {
        super.init(texture: nil, color: UIColor(white: 1, alpha: 0.3), size: size)
        self.name = "stripe"
        self.orientation = orientation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
