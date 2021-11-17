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
            cardView(card: card)
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
    @ViewBuilder private func cardView(card: EmojiMemoryGame.Card) -> some View {
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
}

struct CardView: View {
    private let card: EmojiMemoryGame.Card
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120-90))
                    .padding(DrawingConstants.padding)
                    .opacity(DrawingConstants.opacity)
                Text(card.content)
                    .font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    // 局部变量封装
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.8
        static let padding: CGFloat = 5
        static let opacity: CGFloat = 0.5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
//        Group {
//            EmojiMemoryGameView(game: game)
//
//        }
    }
}
