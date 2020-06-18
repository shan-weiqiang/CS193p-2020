//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 单译 on 2020/5/28.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject{
    

    
   @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String>{
        
        let emojis: Array<String> = ["👻", "😈","👽","🤖"]
        
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count){ pairIndex in
            
        return emojis[pairIndex]
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
