//
//  GameScene.swift
//  notFrogger
//
//  Created by Phyllis Wong on 2/22/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    /// The game board.
    var gameBoard: Board!
    /// The player.
    var player: Player!
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        makeBoard()
        makePlayer()
        startSpawningCars(on: gameBoard)
        setupSwipeGestures()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.Player | PhysicsCategory.Car {
            print("car hit the player")
        } else if collision == PhysicsCategory.Player | PhysicsCategory.Coin {
            print("player got the coin")
        }
    }
    
    func setupSwipeGestures() {
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRight.direction = .right
        self.view?.addGestureRecognizer(swipeRight)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeft.direction = .left
        self.view?.addGestureRecognizer(swipeLeft)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeUp.direction = .up
        self.view?.addGestureRecognizer(swipeUp)
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        swipeDown.direction = .down
        self.view?.addGestureRecognizer(swipeDown)
    }
    
}



// MARK: Private methods.
private extension GameScene {
    /// Make a grid with 3 horizontal stripes and 3 vertical stripes.
    func makeBoard() {
        gameBoard = Board(size: size)
        addChild(gameBoard)
    }
    
    /// Create a player and place it at the center of the screen.
    func makePlayer() {
        player = Player()
        addChild(player)
        // Place player at center of screen.
        player.position.x = size.width / 2
        player.position.y = size.height / 2
    }
    
    /// Start the game logic that handles enemy spawning and moving.
    func startSpawningCars(on board: Board) {
        // Create SKAction to handle spawning cars.
        let spawnCarsAction = SKAction.run {
            // Grab a random stripe.
            let stripes = board.stripes.all
            let randomIndex = Int(arc4random_uniform(UInt32(stripes.count)))
            let randomStripe = stripes[randomIndex]
            var car: Car!
            // Spawn an car and move them to their destination.
            switch Direction.random() {
                
            case .up:
                car = Car(spawn: randomStripe.bottom)
                self.addChild(car)
                let moveAction = SKAction.move(to: randomStripe.top, duration: 3.0)
                let removeAction = SKAction.run(car.removeFromParent)
                car.run(SKAction.sequence([moveAction, removeAction]))
                
            case .down:
                car = Car(spawn: randomStripe.top)
                self.addChild(car)
                let moveAction = SKAction.move(to: randomStripe.bottom, duration: 3.0)
                let removeAction = SKAction.run(car.removeFromParent)
                car.run(SKAction.sequence([moveAction, removeAction]))
            }
        }
        run(SKAction.repeatForever(SKAction.sequence([spawnCarsAction, SKAction.wait(forDuration: 1)])))
        
    }
    
    
    // FIXME: Make coin class!!!
    func setupCoinPhysics(coin: SKSpriteNode) {
        //FIXME: get size of coin, and radius
        coin.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        coin.physicsBody?.affectedByGravity = false
        coin.physicsBody?.categoryBitMask = PhysicsCategory.Coin
        coin.physicsBody?.collisionBitMask = PhysicsCategory.None
        coin.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }
    
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer) {
        player.move = .right
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer) {
        player.move = .left
    }
    
    @objc func swipedUp(sender: UISwipeGestureRecognizer) {
        player.move = .up
    }
    
    @objc func swipedDown(sender: UISwipeGestureRecognizer) {
        player.move = .down
    }
}
