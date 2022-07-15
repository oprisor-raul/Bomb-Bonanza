//
//  MoneyManager.swift
//  Bomb Bonanza
//
//  Created by Oprișor Raul-Alexandru on 12.07.2022.
//

import Foundation
let userDefaults = UserDefaults.standard

class Money: NSObject {
    //    Every user starts with 10$ and every change gets automatically stored
    @Published var money: Double = userDefaults.object(forKey: "money") as? Double ?? 100.0
    
    func amount() -> Double {
        return money
    }
    
    func calculateBalance(_ amountString: String, _ previousBetString: String) {
        //        Calculates the balance by adding the won sum and subtracting the bet amount
        let amount = Double(amountString) ?? 0.0
        let previousBet = Double(previousBetString) ?? 0.0
        money = money + amount - previousBet
        //        Every change is automatically stored
        UserDefaults.standard.set(money, forKey: "money")
    }
}
