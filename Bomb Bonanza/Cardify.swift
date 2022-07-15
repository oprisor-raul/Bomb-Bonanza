//
//  Cardify.swift
//  Bomb Bonanza
//
//  Created by Oprișor Raul-Alexandru on 11.07.2022.
//

import SwiftUI


struct Cardify: AnimatableModifier {
    //    Cardify the CardView (aka. Transform into the shape of a card)
    var isFaceUp: Bool
    var GameEndedFaceUp: Bool
    var rotation: Double
    var animatableData: Double{
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool, bombGameEndedFaceUp: Bool) {
        rotation = isFaceUp ? 0.0 : 180.0
        self.isFaceUp = isFaceUp
        self.GameEndedFaceUp = bombGameEndedFaceUp
    }
    
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if self.isFaceUp && rotation < 90 {
                shape.strokeBorder(lineWidth: DrawingConstants.strokeBorder)
                content
            }
            else if self.GameEndedFaceUp {
                shape.strokeBorder(lineWidth: DrawingConstants.strokeBorder)
                content
            }
            else{
                shape.fill()
            }
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius = 20.0
        static let strokeBorder = 3.0
    }
}


extension View {
    func cardify(isFaceUp: Bool, GameEndedFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, bombGameEndedFaceUp: GameEndedFaceUp))
    }
}

