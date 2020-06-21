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
            Spacer()
            HStack{
                Spacer()
                Text(viewModel.theme.name)
                .font(Font.headline)
                Spacer()
                Text("Score:\(viewModel.score)")
                    .font(Font.headline)
                Spacer()
            }
            .padding(20)
            
            Divider()
            Grid(items: viewModel.cards){ card in
                CardView(card: card, gradient: self.viewModel.theme.gradient)
                           //                .aspectRatio(2/3, contentMode: .fit)
                           .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 3)){
                                self.viewModel.choose(card: card)

                            }
                            
                            
                }
                           .padding(5)
                
                   }
                       
                   .padding()
                   .foregroundColor(viewModel.theme.color)
            
            
            Divider()
            Button("New Game"){
                self.viewModel.createNewGame()
            }
            
            Spacer()
        }
       
        
    }
    
}

struct CardView: View{
    
    var card: MemoryGame<String>.Card
    var gradient: LinearGradient
    var body: some View{
        
        GeometryReader{geometry in
            ZStack {
                if self.card.isFaceUp{
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                        .transition(AnyTransition.identity)
                    RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                    Text(self.card.content)
                    
                }else{
                    if !self.card.isMatched{
                        RoundedRectangle(cornerRadius: self.cornerRadius).fill(self.gradient)
                    }
                }
            }
            .font(Font.system(size:self.fontSize(for: geometry.size)))
            
        }
        
    }
    
    // MARK: - DRAWING CONSTANTS
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    func fontSize(for size: CGSize)-> CGFloat{
        min(size.width, size.height) * 0.75
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
