//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Harlans on 2021/11/11.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    // static 修饰的变量不能载实例变量中使用
    static let emojis = ["😀","😁","😍","🥰","🤪","😚","😎","😭","😰","🤬","🙄","😈","🤐","😮‍💨","🎃","😬","😬","🤖","👻","🤖","👻","🤖","👻",]
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 4) { index in
            EmojiMemoryGame.emojis[index]
        }
    }
    
    // 被 @Published 修饰的model 只要改变了就会向全世界发起通知
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
}
