//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 单译 on 2020/5/28.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject{
    
    
    
    @Published private var model: MemoryGame<String>
    
    //MARK: theme
    var theme: Theme
    
    
    //MARK: Themes
    static var themes:[Theme] = [
        Theme(named: "faces", emojisList: ["👻", "😈","👽","🤖"], numberOfCards: 4, colored: Color.orange),
        Theme(named: "animals", emojisList: ["🐶","🐱","🐭","🐻","🐯"], colored: Color.blue),
        Theme(named: "sports", emojisList: ["⚽️","🏀","🏈","⚾️","🥎"], colored: Color.green),
        Theme(named: "vehicles", emojisList: ["🚗","🚎","🛴","🚜","🚓","✈️","🚌","🚁","⛵️","🛵","🚲"], colored: Color.purple),
        Theme(named: "flags", emojisList: ["🏴‍☠️","🏳️‍🌈","🇦🇿","🇦🇷","🇨🇺","🇨🇳"], numberOfCards: 4, colored: Color.blue),
        Theme(named: "food", emojisList: ["🍔","🍞","🍟","🥪","🍤","🍗","🥮"], numberOfCards: 6, colored: Color.pink)
    ]
    
    //MARK: Theme struct
    struct Theme {
        var name: String
        var emojis: [String]
        var numberOfCards: Int?
        var color: Color
        
        init(named name: String, emojisList emojis: [String], numberOfCards number: Int? = nil, colored color: Color) {
            self.name = name
            self.emojis = emojis
            numberOfCards = number ?? Int.random(in: 0..<emojis.count)
            self.color = color
            
        }
    }
    
    init(theme: EmojiMemoryGame.Theme? = nil) {
        let startTheme = theme ?? EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        self.theme = startTheme
        func createMemoryGame() -> MemoryGame<String>{
            return MemoryGame<String>(numberOfPairsOfCards: startTheme.numberOfCards!){pairIndex in
                startTheme.emojis[pairIndex]
            }
        }
        model = createMemoryGame()
    }
    
    // MARK: Add a theme
    func addThemes(theme: EmojiMemoryGame.Theme){
        EmojiMemoryGame.themes.append(theme)
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
