//
//  BombGameView.swift
//  Bomb Bonanza
//
//  Created by Oprișor Raul-Alexandru on 09.07.2022.
//

import SwiftUI


struct BombGameView: View {
    @ObservedObject var bonanzaBombGame: BonanzaBombGame
    @ObservedObject var myMoney: MoneyManager
    
    @State private var bombGameStarted: Bool = false
    @State private var showAlertNoMoney: Bool = false
    
    @State private var moneyAmount = "5$"
    let filterMoneyAmount: [String] = ["1$","5$","10$","50$","100$","All In"]
    @State private var bombAmount = "5"
    let filterBombAmount: [String] = ["1","3","5","10","20","24"]
    
    var body: some View {
        //        UI of the bomb game
        HStack {
            balance
            Spacer()
            if !bonanzaBombGame.hasEnded() && bombGameStarted {
                previousBetAmount
            }
        }
        Spacer()
        if bombGameStarted {
            bombGameBody
        }
        else {
            titleOfBombGame
            informationAboutBombGame
        }
        Spacer()
        if bonanzaBombGame.hasEnded() || bombGameStarted == false {
            PickerGamblingMoneyAmount
            PickerBombAmount
        }
        bombGameButtons
    }
    
    var balance: some View {
        //        Balance Display
        Text("Balance: \(neatStringConverter(myMoney: myMoney.amount()))$")
            .font(.title2)
            .foregroundColor(DrawingConstants.accentColor)
            .onTapGesture {
                myMoney.calculateBalance(amountString: "10.0", previousBetString: "0.0")
            }
    }
    
    var previousBetAmount: some View {
        //        Displays the amount previously bet
        Text("Bet: \(bonanzaBombGame.hasBetted())$")
            .font(.title2)
            .foregroundColor(DrawingConstants.accentColor)
            .padding(.horizontal)
    }
    
    var titleOfBombGame: some View {
        //        Image with title of the bomb game
        Image("TransparentBombBonanzaLogo")
            .resizable()
            .frame(width: DrawingConstants.titleWidth, height: DrawingConstants.titleHeight, alignment: .center)
            .aspectRatio(contentMode: .fill)
            .padding(.horizontal)
    }
    var informationAboutBombGame: some View {
        //        Short description of the bomb game
        Text("Bomb Bonanza's adventure is unlike any other, offering an exciting, fun-filled experience. Gamblers will tread their way through the minefield to come out victorious. \n\nBomb Bonanza is much like the old-time classic Minesweeper. Players, must move across the field and avoid the bombs. The layout of the game has been skillfully designed to allow seamless play and easy understanding. Players get a fantastic return of 97%")
            .font(.title3)
            .padding(.horizontal)
    }
    
    var bombGameBody: some View {
        //        Bomb game with all the cards
        VStack {
            AllCardsView(bonanzaBombGame, myMoney)
        }
    }
    
    var PickerGamblingMoneyAmount: some View {
        //        Picker for the amount of money that will be gambled
        VStack {
            HStack {
                Text("Choose amount to gamble:")
                    .foregroundColor(DrawingConstants.secondaryAccentColor)
                Spacer()
            }.padding(.horizontal)
            Picker(selection: $moneyAmount,
                   label: Text("Choose amount to gamble:"),
                   content: {
                ForEach(filterMoneyAmount, id: \.self) { option in
                    Text(option)
                        .tag(option)
                }
            }).pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
        }
    }
    
    var PickerBombAmount: some View {
        //        Picker for the amount of bombs that will be chosen
        VStack {
            HStack {
                Text("Choose number of bombs:")
                    .foregroundColor(DrawingConstants.secondaryAccentColor)
                Spacer()
            }.padding(.horizontal)
            Picker(selection: $bombAmount,
                   label: Text("Choose number of bombs:"),
                   content: {
                ForEach(filterBombAmount, id: \.self) { option in
                    Text(option)
                        .tag(option)
                }
            }).pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
        }
    }
    
    var bombGameButtons: some View{
        //        All buttons present in the game
        HStack {
            if bombGameStarted {
                if !bonanzaBombGame.hasEnded() {
                    cashoutButton
                }
                Spacer()
                newBombGameButton
            }
            else
            {
                bombStartGame
            }
        }
        .buttonStyle(.bordered)
        .padding(.horizontal)
        .padding(.vertical)
        .alert(isPresented: $showAlertNoMoney)
        {
            return Alert(title: Text("Insufficient funds!"), message: Text("Please add more funds!"), dismissButton: .default(Text("OK")))
        }
    }
    
    var bombStartGame: some View {
        //        "Start Game" Button, starts a gambling session with the picked input
        Button("Start Game") {
            withAnimation {
                let bet = moneyAmount.dropLast()
                let betDouble = (Double(bet) ?? 0)
                if (myMoney.amount() >= betDouble) && (myMoney.amount() >= 0.01){
                    bombGameStarted = true
                    bonanzaBombGame.restart(betAmount: Double(bet) ?? myMoney.amount(), numberOfBombs: Int(bombAmount) ?? 0)}
                else {
                    showAlertNoMoney = true
                }
            }
        }
    }
    
    var cashoutButton: some View {
        //        "Cashout" Button, starts a new gambling session with the picked input
        Button("Cashout") {
            withAnimation {
                let previousPayout = bonanzaBombGame.cashout()
                if previousPayout != "0.0" {
                    myMoney.calculateBalance(amountString: previousPayout, previousBetString: bonanzaBombGame.hasBetted())
                }
            }
        }
    }
    
    var newBombGameButton: some View {
        //        "New Game" Button, cashes Out if possible and starts a gambling session with the picked input
        Button("New Game") {
            let previousPayout = bonanzaBombGame.cashout()
            if previousPayout != "0.0" {
                myMoney.calculateBalance(amountString: previousPayout, previousBetString: bonanzaBombGame.hasBetted())
            }
            let bet = moneyAmount.dropLast()
            if (myMoney.amount() >= (Double(bet) ?? 0)) && (myMoney.amount() >= 0.01) {
                bonanzaBombGame.restart(betAmount: Double(bet) ?? myMoney.amount(), numberOfBombs: Int(bombAmount) ?? 0)}
            else {
                showAlertNoMoney = true
            }
        }
        .buttonStyle(.bordered)
    }
}

struct AllCardsView: View {
    //    UI for all cards
    @ObservedObject var bombGame: BonanzaBombGame
    @ObservedObject var myMoney: MoneyManager
    @State private var showingAlertBomb: Bool = false
    
    init(_ bombGame: BonanzaBombGame, _ myMoney: MoneyManager) {
        self.bombGame = bombGame
        self.myMoney = myMoney
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem(), GridItem()]) {
            ForEach(bombGame.cards) { card in
                if card.GameEndedFaceUp {
                    //        Displays the cards after the game has ended, the user can see other viable options for the cards
                    CardViews(card)
                        .aspectRatio(DrawingConstants.aspectRatio, contentMode: .fit)
                        .foregroundColor(DrawingConstants.secondaryAccentColor)
                        .opacity(DrawingConstants.opacity)
                }
                else {
                    //        Displays the cards during the game (hidden)
                    CardViews(card)
                        .aspectRatio(DrawingConstants.aspectRatio, contentMode: .fit)
                        .foregroundColor(DrawingConstants.accentColor)
                        .onTapGesture {
                            withAnimation {
                                if !bombGame.hasEnded() {
                                    bombGame.choose(card)
                                    showingAlertBomb = bombGame.hasEnded()
                                    if (showingAlertBomb) {
                                        myMoney.calculateBalance(amountString: "0.0", previousBetString: bombGame.hasBetted())
                                    }
                                }
                            }
                        }
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical)
        .alert(isPresented: $showingAlertBomb) {
            Alert(title: Text("You Lost!"), message: Text("Lost amount: \(bombGame.hasBetted())$ !"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CardViews: View {
    //    UI for a single card
    private let card: BombGame<String>.Card
    
    init(_ card: BombGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            Text(card.content)
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        .modifier(Cardify(isFaceUp: card.isFaceUp, bombGameEndedFaceUp: card.GameEndedFaceUp))
    }
}


// MARK: - Other useful functions and DrawingConstants for the UI 


func neatStringConverter(myMoney: Double) -> String {
    //    Converts any Double to a String that can be neatly displayed to the user
    if myMoney > 0 {
        return String(format: "%.2f", myMoney)
    }
    else {
        return "0.0"
    }
}

struct DrawingConstants {
    //    DrawingConstants used to draw the UI
    static let accentColor = Color(.orange)
    static let secondaryAccentColor = Color(.systemGray)
    
    static let opacity = 0.75
    
    static let aspectRatio = calculateAspectRatio()
    static let titleHeight = calculateHeight()
    static let titleWidth = calculatewidth()
}

func calculateAspectRatio() -> Double {
    //    Calculate the aspect ratio for a well fitted gaming experience
    if Int(UIScreen.main.bounds.size.height) < 700 {
        return (1.0/1.1)
    }
    else {
        return (3.0/4.5)
    }
}

func calculatewidth() -> Double {
    //    Calculate the title width for a well fitted gaming experience
    if Int(UIScreen.main.bounds.size.height) < 700 {
        return (200)
    }
    else {
        return (390)
    }
}

func calculateHeight() -> Double {
    //    Calculate the title height for a well fitted gaming experience
    return (calculatewidth()/4)
}
