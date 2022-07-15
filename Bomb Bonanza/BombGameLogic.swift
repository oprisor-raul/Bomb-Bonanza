//
//  BombGameLogic.swift
//  Bomb Bonanza
//
//  Created by Oprișor Raul-Alexandru on 09.07.2022.
//


import Foundation

struct BombGame<CardContent> {
    private(set) var previousPayoutMultiplier = 1.0
    private(set) var numberOfChosenCards = 0
    private(set) var ended: Bool = false
    
    private(set) var cards: Array<Card>
    private(set) var numberOfBombs: Int
    private(set) var betAmount: Double
    
    init(betAmount: Double, numberOfBombs: Int, createTick: () -> CardContent, createBomb: () -> CardContent) {
        self.betAmount = betAmount
        cards = Array<Card>()
        self.numberOfBombs = numberOfBombs
        allocateNewData(createTick, createBomb)
    }
    
    struct Card:Identifiable {
        let id: Int
        var isFaceUp = false
        var GameEndedFaceUp = false
        var isBomb = false
        var content: CardContent
    }
    
    // MARK: - Mathematical Calculations
    
    func calculate_probability() -> Double {
        var probability = 1.0
        for index in 0...numberOfChosenCards {
            probability = probability * Double( Double( 25 - (index) - numberOfBombs) / Double( 25 - index) )
        }
        return probability
    }
    
    func roundNumber(numberToRound: Double) -> Double {
        return Double(round(100 * numberToRound) / 100)
    }
    
    func calculatePayout(bet: Double) -> Double {
        return roundNumber(numberToRound: self.previousPayoutMultiplier * Double(bet))
    }
    
    // MARK: - Other functions
    
    func convertDoubleToString(numberToConvert: Double) -> String {
        if numberToConvert < 100{ return String(format: "%.2f", numberToConvert)}
        else { return String(format: "%.0f", numberToConvert)}
    }
    
    // MARK: - Other functions game
    func hasEnded() -> Bool {
        return self.ended
    }
    
    func hasBetted() -> String {
        return String(roundNumber(numberToRound: self.betAmount))
    }
    
    mutating func choose(_ card: Card, createStar: () -> CardContent) {
        //        Function for choosing a specific card
        if ((!cards[card.id].isFaceUp) && (!self.ended)){
            if cards[card.id].isBomb{
                SoundManager.instance.playSound(nameOfSound: "ChooseExplosion")
                cards[card.id].isFaceUp.toggle()
                ended = true
                GameEndFaceUpTransformation(createStar)
            }
            else{
                SoundManager.instance.playSound(nameOfSound: "ChooseCoin")
                var payout = (0.97 * 1/(calculate_probability()))
                payout = roundNumber(numberToRound: payout)
                self.previousPayoutMultiplier = payout
                cards[card.id].content = convertDoubleToString(numberToConvert: payout) as! CardContent
                cards[card.id].isFaceUp.toggle()
                numberOfChosenCards = numberOfChosenCards + 1}
        }
    }
    
    mutating func allocateNewData(_ createTick: () -> CardContent,_ createBomb: () -> CardContent) {
        //        Returning all the variables to the initial state
        for index in 0..<25 {
            let newcontent = createTick()
            cards.append(Card(id: index, content: newcontent))
        }
        
        for _ in 0..<self.numberOfBombs {
            var positionOfBomb: Int = Int.random(in: 0..<25)
            while cards[positionOfBomb].isBomb == true{
                positionOfBomb = Int.random(in: 0..<25)
            }
            cards[positionOfBomb].isBomb = true
            cards[positionOfBomb].content = createBomb()
        }
    }
    
    mutating func deleteGameData() {
        //        Deletes all data saved in the current gambling session
        self.cards.removeAll()
        self.previousPayoutMultiplier = 1.0
        self.numberOfChosenCards = 0
        self.ended = false
    }
    
    mutating func restart(betAmount: Double, numberOfBombs: Int, createTick: () -> CardContent, createBomb: () -> CardContent) {
        //        Restarts a game with the new input
        self.betAmount = betAmount
        self.numberOfBombs = numberOfBombs
        deleteGameData()
        allocateNewData(createTick, createBomb)
        SoundManager.instance.playSound(nameOfSound: "RestartAnotherOne")
    }
    
    mutating func GameEndFaceUpTransformation(_ createStar: () ->CardContent) {
        //        Prepearing the cards to be displayed in a neat way after the game has ended
        for index in 0..<25 {
            if !cards[index].isBomb && !cards[index].isFaceUp {
                cards[index].content = createStar()
                cards[index].GameEndedFaceUp = true
            }
            if cards[index].isBomb && !cards[index].isFaceUp {
                cards[index].GameEndedFaceUp = true
            }
        }
    }
    
    mutating func cashout(createStar: () ->CardContent) -> String {
        //        Reciving all the money won
        if !self.ended && self.previousPayoutMultiplier != 1.0 {
            let payout = calculatePayout(bet: self.betAmount)
            GameEndFaceUpTransformation(createStar)
            self.ended = true
            SoundManager.instance.playSound(nameOfSound: "CashoutCoins")
            return String(payout)
        }
        return "0.0"
    }
}
