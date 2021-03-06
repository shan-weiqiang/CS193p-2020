//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 单译 on 2020/5/28.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame{
    

    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String>{
        
        let emojis: Array<String> = ["👻", "😈","👽","🤖","👺"]
        
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)){ pairIndex in
            
            return emojis[Int.random(in: 0..<emojis.count)]
        }

    }
    
    // MARK: Access to the model
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    // MARK: Intents
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}
