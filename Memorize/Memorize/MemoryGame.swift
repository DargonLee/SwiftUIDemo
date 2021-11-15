//
//  MemoryGame.swift
//  Memorize
//
//  Created by Harlans on 2021/11/11.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    // private(set) 对内可修改, 对外可见
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            /*
             var faceUpCardIndices = [Int]()
             for index in cards.indices {
                 if cards[index].isFaceUp {
                     faceUpCardIndices.append(index)
                 }
             }
             */
            // 函数式编程
            let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            
            /*
             if faceUpCardIndices.count == 1 {
                 return faceUpCardIndices.first
             }
             return nil
             */
            return faceUpCardIndices.oneAndOnly
        }
        set {
            /*
             for index in cards.indices {
                 cards[index].isFaceUp = (index == newValue)
             }
             */
            cards.indices.forEach({
                cards[$0].isFaceUp = ($0 == newValue)
            })
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMached
        {
            if let potenialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potenialMatchIndex].content {
                    cards[chosenIndex].isMached = true
                    cards[potenialMatchIndex].isMached = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent:(Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMached = false
        let content: CardContent
        var id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return self.first
        }
        return nil
    }
}

/*
// 枚举示例
struct FryOrderSize {
    
}
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drinks(String, ounces: Int)
    case cookie
    
    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
            case .hamburger(let pattyCount): return false
            case .fries, .cookie: return  true
            case .drinks(_, let ounces): return  true
        }
    }
}
*/
