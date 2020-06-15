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
        Theme(named: "Faces", emojisList: ["👻", "😈","👽","🤖"], numberOfCards: 4, colored: Color.orange, gradient: Gradients.blue_red),
        Theme(named: "Animals", emojisList: ["🐶","🐱","🐭","🐻","🐯"], colored: Color.blue, gradient: Gradients.orange_green),
        Theme(named: "Sports", emojisList: ["⚽️","🏀","🏈","⚾️","🥎"], colored: Color.green, gradient: Gradients.red_black),
        Theme(named: "Vehicles", emojisList: ["🚗","🚎","🛴","🚜","🚓","✈️","🚌","🚁","⛵️","🛵","🚲"], colored: Color.purple, gradient: Gradients.yellow_black),
        Theme(named: "Flags", emojisList: ["🏴‍☠️","🏳️‍🌈","🇦🇿","🇦🇷","🇨🇺","🇨🇳"], numberOfCards: 4, colored: Color.blue, gradient: Gradients.purple_white),
        Theme(named: "Food", emojisList: ["🍔","🍞","🍟","🥪","🍤","🍗","🥮"], numberOfCards: 6, colored: Color.pink, gradient: Gradients.yellow_white)
    ]
    
    struct Gradients {
        static let blue_red: LinearGradient = LinearGradient(gradient: Gradient(colors: [.blue,.red]), startPoint: .bottom, endPoint: .top)
        static let red_black: LinearGradient = LinearGradient(gradient: Gradient(colors: [.red,.black]), startPoint: .bottomLeading, endPoint: .topLeading)
        static let yellow_black: LinearGradient = LinearGradient(gradient: Gradient(colors: [.yellow,.black]), startPoint: .center, endPoint: .trailing)
        static let yellow_white: LinearGradient = LinearGradient(gradient: Gradient(colors: [.yellow,.white]), startPoint: .topLeading, endPoint: .trailing)
        static let purple_white: LinearGradient = LinearGradient(gradient: Gradient(colors: [.purple,.white]), startPoint: .leading, endPoint: .trailing)
        static let orange_green: LinearGradient = LinearGradient(gradient: Gradient(colors: [.orange,.green]), startPoint: .bottomTrailing, endPoint: .zero)

    }
    
    
    
    //MARK: initialize using a random theme
    init(theme: EmojiMemoryGame.Theme? = nil) {
        let startTheme = theme ?? EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        self.theme = startTheme
        model = EmojiMemoryGame.createMemoryGame(using: startTheme)
    }
    
    // MARK: Add a theme
    func addThemes(theme: EmojiMemoryGame.Theme){
        EmojiMemoryGame.themes.append(theme)
    }
    
    //MARK: create game using specified theme
    
    static func createMemoryGame(using theme: EmojiMemoryGame.Theme) -> MemoryGame<String>{
               return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCards!){pairIndex in
                   theme.emojis[pairIndex]
               }
           }
    
    //MARK: createNewGame
    func createNewGame(){
        theme = EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        model = EmojiMemoryGame.createMemoryGame(using: theme)
    }
    
    
    // MARK: Access to the model
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    //MARK: Acess to the score
    
    var score: Int{
        return model.score
    }
    
    // MARK: Intents
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    //MARK: Theme struct
    struct Theme {
        var name: String
        var emojis: [String]
        var numberOfCards: Int?
        var color: Color
        var gradient:LinearGradient
        
        init(named name: String, emojisList emojis: [String], numberOfCards number: Int? = nil, colored color: Color, gradient: LinearGradient) {
            self.name = name
            self.emojis = emojis
            numberOfCards = number ?? Int.random(in: 1..<emojis.count)
            self.color = color
            self.gradient = gradient
            
        }
    }
}
