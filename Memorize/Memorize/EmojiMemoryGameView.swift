//
//  ContentView.swift
//  Memorize
//
//  Created by Harlans on 2021/11/8.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // @ObseredObject model 变化了就重构UI
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMached && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    private let card: EmojiMemoryGame .Card
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if (card.isMached) {
                    shape.opacity(0.0)
                } else {
                    shape.fill(.red)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(game: EmojiMemoryGame())
    }
}
