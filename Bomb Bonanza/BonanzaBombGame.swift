//
//  BonanzaBombGame.swift
//  Bomb Bonanza
//
//  Created by Oprișor Raul-Alexandru on 09.07.2022.
//

import SwiftUI

class BonanzaBombGame: ObservableObject {
    
    private static func createBombGame() -> BombGame<String> {
        BombGame<String>(betAmount: 0,
                         numberOfBombs: 0,
                         createTick: {return "✅"},
                         createBomb: {return "💣"})
    }
    
    @Published private var model = createBombGame()
    
    var cards: Array<BombGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - GameIntent
    
    func choose (_ card: BombGame<String>.Card) {
        model.choose(card, createStar: {return "⭐️"})
    }
    
    func restart (betAmount: Double, numberOfBombs: Int) {
        model.restart(betAmount: betAmount,
                      numberOfBombs: numberOfBombs,
                      createTick: {return "✅"},
                      createBomb: {return "💣"})
    }
    
    func cashout() -> String {
        //        Stop the Game and get the money
        let payoutAmount: String = String(model.cashout(createStar: {return "⭐️"}))
        return payoutAmount
    }
    
    func hasEnded() -> Bool {
        return model.hasEnded()
    }
    
    func hasBetted() -> String {
        return model.hasBetted()
    }
}
