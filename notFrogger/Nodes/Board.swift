//
//  Board.swift
//  notFrogger
//
//  Created by Phyllis Wong on 3/7/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import SpriteKit

/// The stripes of a board held in arrays that describe the stripes orientation.
class Stripes {
    /// Stripes that are oriented horizontally.
    var horizontal = [Stripe]()
    /// Stripes that are oriented vertically.
    var vertical = [Stripe]()
    /// The total number of stripes.
    var count: Int {
        get {
            return all.count
        }
    }
    var all: [Stripe] {
        get {
            return horizontal + vertical
        }
    }
}

/// The game board that provides Stripe nodes for Obstacles nodes to travel.
class Board: SKNode {
    
    var stripes: Stripes!
    /// The size of the board which will determine how long the stripes are.
    var size: CGSize!
    
    /// Creates a SKNode with Stripe nodes as its children.
    ///
    /// - Paremeter size: The size of the board which determiens the size of the stripes.

    init(size: CGSize) {
        super.init()
        self.size = size
        self.name = "board"
        make()
    }
    
    // Required to make our custome class work
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Board {
    
    /// Create the stripes for the board and places them in a grid layout.
    func make() {
        stripes = Stripes()
        
        // Make rows
        for row in -1 ... 1 {
            let stripe = Stripe(size: CGSize(width: size.width, height: 60), orientation: .horizontal)
            addChild(stripe)
            stripes.horizontal.append(stripe)
            stripe.position.x = size.width / 2
            stripe.position.y = size.height / 2 - CGFloat(65 * row)
            
        }

        // Make columns
        for column in -1 ... 1 {
            let stripe = Stripe(size: CGSize(width: 60, height: size.height), orientation: .vertical)
            addChild(stripe)
            stripes.vertical.append(stripe)
            stripe.position.x = size.width / 2  - CGFloat(65 * column)
            stripe.position.y = size.height / 2
        }
    }
}


