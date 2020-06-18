//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 单译 on 2020/5/24.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(items: viewModel.cards){ card in
            CardView(card: card)
                //                .aspectRatio(2/3, contentMode: .fit)
                .onTapGesture {self.viewModel.choose(card: card)}
                .padding(5)
        }
            
        .padding()
        .foregroundColor(Color.orange)
        
    }
    
}






struct CardView: View{
    
    var card: MemoryGame<String>.Card
    var body: some View{
        
        GeometryReader{geometry in
            
            if self.card.isFaceUp || !self.card.isMatched{
                ZStack {
                    
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockWise: true)
                        .padding(5)
                        .opacity(0.4)
                    Text(self.card.content)
                        .font(Font.system(size:self.fontSize(for: geometry.size)))
                    
                }
                .cardify(isFaceUp: self.card.isFaceUp)
            }
            
        }
        
    }
    
    
    
    // MARK: - DRAWING CONSTANTS
    
    
    private func fontSize(for size: CGSize)-> CGFloat{
        min(size.width, size.height) * 0.7
    }
    
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let emojigame = EmojiMemoryGame()
        emojigame.choose(card: emojigame.cards[0])
        return EmojiMemoryGameView(viewModel: emojigame)
    }
}

