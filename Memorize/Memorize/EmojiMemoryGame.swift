//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Harlans on 2021/11/11.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    // static 修饰的变量不能载实例变量中使用
    private static let emojis = ["😀","😁","😍","🥰","🤪","😚","😎","😭","😰","🤬","🙄","😈","🤐","😮‍💨","🎃","😬","😬","🤖","👻","🤖","👻","🤖","👻",]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 4) { index in
            EmojiMemoryGame.emojis[index]
        }
    }
    
    // 被 @Published 修饰的model 只要改变了就会向全世界发起通知
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
}
