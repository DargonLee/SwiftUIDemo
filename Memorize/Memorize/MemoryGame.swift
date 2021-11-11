//
//  MemoryGame.swift
//  Memorize
//
//  Created by Harlans on 2021/11/11.
//

import Foundation

struct MemoryGame<CardContent> {
    
    // private(set) 对内可修改, 对外可见
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContent:(Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMached: Bool = false
        var content: CardContent
    }
}
