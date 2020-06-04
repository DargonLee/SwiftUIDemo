//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Harlans on 2020/6/1.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

fileprivate func cardContentFactory(pairIndex: Int) -> String {
    return "😀"
}

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🐼", "🐶", "🐵", "🐷", "😀", "🦁", "🦊"]
        return MemoryGame(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

