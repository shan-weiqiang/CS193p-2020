//
//  MemoryGame.swift
//  Memorize
//
//  Created by 单译 on 2020/5/28.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards: Array<Card>
    
    private var indexOfTheOnlyFaceUpCard: Int?{
        get{cards.indices.filter { cards[$0].isFaceUp}.only}
        set{
            for index in cards.indices{
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
                }
                self.cards[chosenIndex].isFaceUp = true
            }else{
               
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
            
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
        var isFaceUp: Bool = false{
            didSet{
                if isFaceUp{
                    startUsingBonusTime()
                }else{
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false{
            didSet{
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval{
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }else{
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        var bonusTimeRemaining: TimeInterval{
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double{
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var isConsumingBonusTime: Bool{
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        var hasEarnedBonus: Bool{
            isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil{
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
        
    }
}


