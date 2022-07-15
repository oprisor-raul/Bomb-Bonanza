//
//  MoneyManager.swift
//  Bomb Bonanza
//
//  Created by Oprișor Raul-Alexandru on 15.07.2022.
//

import Foundation

class MoneyManager: ObservableObject {
    private static func createMoneyManager() -> Money {
        return Money()
    }
    
    @Published private var model = createMoneyManager()
    
    func amount() -> Double {
        return model.amount()
    }
    
    func calculateBalance(amountString: String, previousBetString: String) {
        model.calculateBalance(amountString, previousBetString)
    }
}
