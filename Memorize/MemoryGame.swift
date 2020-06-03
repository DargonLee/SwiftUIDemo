//
//  MemoryGame.swift
//  Memorize
//
//  Created by Harlans on 2020/6/1.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    mutating func choose(card: Card) {
        print("card chosen before: \(card)")
        let chosenIndex = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogous
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
