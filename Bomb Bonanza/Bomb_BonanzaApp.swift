//
//  Bomb_BonanzaApp.swift
//  Bomb Bonanza
//
//  Created by Oprișor Raul-Alexandru on 09.07.2022.
//

import SwiftUI

@main
struct Bomb_BonanzaApp: App {
    private let game = BonanzaBombGame()
    private let money = MoneyManager()
    var body: some Scene {
        WindowGroup {
            BombGameView(bonanzaBombGame: game, myMoney: money)
        }
    }
}
