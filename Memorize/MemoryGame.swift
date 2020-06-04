//
//  MemoryGame.swift
//  Memorize
//
//  Created by Harlans on 2020/6/1.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
    var indexOfTheoneAndonlyFaceupCard: Int? {
        get {
            cards.indices.filter{ cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen before: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            if let potentialmatchIndex = indexOfTheoneAndonlyFaceupCard {
                if cards[chosenIndex].content == cards[potentialmatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialmatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            }else {
                indexOfTheoneAndonlyFaceupCard = chosenIndex
            }
        }
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
