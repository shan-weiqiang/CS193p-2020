//
//  MemoryGame.swift
//  Memorize
//
//  Created by 单译 on 2020/5/28.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    var cards: Array<Card>
    var score: Int = 0
    var date = Date()
    var timeFlag: TimeInterval = 0
    
    var indexOfTheOnlyFaceUpCard: Int?{
        get{cards.indices.filter { cards[$0].isFaceUp}.only}
        set{
            for index in cards.indices{
                if cards[index].isFaceUp == true && index != newValue && !cards[index].isMatched{
                    if cards[index].hasSeen == true{
                        score -= 1
                    }
                    cards[index].hasSeen = true
                }
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card){
        
        if let chosenIndex = cards.firstIndexOf(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOnlyFaceUpCard{
                if cards[potentialMatchIndex].content == cards[chosenIndex].content{
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    addScore()
                    
                }
                self.cards[chosenIndex].isFaceUp = true
            }else{
                
                indexOfTheOnlyFaceUpCard = chosenIndex
                timeFlag = date.timeIntervalSinceNow
                print(timeFlag)
            }
            
        }
        
    }
    
    mutating func addScore(){
        let timeSinceNow = date.timeIntervalSinceNow
        score += Int(max(10 - (abs(timeSinceNow) - abs(timeFlag)),1))
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
        var hasSeen:Bool = false
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
    }
}
