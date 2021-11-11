//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Harlans on 2021/11/11.
//

import Foundation


class EmojiMemoryGame {
    static let emojis = ["😀","😁","😍","🥰","🤪","😚","😎","😭","😰","🤬","🙄","😈","🤐","😮‍💨","🎃","😬","😬","🤖","👻","🤖","👻","🤖","👻",]
    
    func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 4) { index in
            EmojiMemoryGame.emojis[index]
        }
    }
    
    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4) { index in
        EmojiMemoryGame.emojis[index]
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
