//
//  MemoryGame.swift
//  Memorize
//
//  Created by 单译 on 2020/5/28.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent>{
    
    var cards: Array<Card>
    
    mutating func choose(card: Card){
        
        if let chosenIndex = cards.firstIndexOf(matching: card){
            self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
        }
        
    }

    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            cards.append(Card(id: pairIndex * 2,  content: cardContentFactory(pairIndex)))
            cards.append(Card(id: pairIndex * 2 + 1, content: cardContentFactory(pairIndex)))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable{
        var id: Int
        
        
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        
    }
}
