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
        
        VStack{
            
            Grid(items: viewModel.cards){ card in
                CardView(card: card)
                    //                .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        withAnimation(Animation.linear(duration: 3)) {
                                                    self.viewModel.choose(card: card)

                        }
                        
                        
                }
                    .padding(5)
            }
            
            Button(action: {
                
                withAnimation(.linear(duration: 3)) {
                                    self.viewModel.resetGame()

                }
            }, label: {Text("New Game")})
            
            
            
            
            
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
                        .rotationEffect(Angle.degrees(self.card.isMatched ? 360:0))
                        .animation(self.card.isMatched ? Animation.linear(duration: 0.8).repeatForever(autoreverses: false) : .default)
                    
                }
                .cardify(isFaceUp: self.card.isFaceUp)
                .transition(AnyTransition.scale)
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

