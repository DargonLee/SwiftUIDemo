//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Harlans on 2020/6/1.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame {
    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2, cardContentFactory: { (pairIndex: Int) -> String in
        return "😀"
    })
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

