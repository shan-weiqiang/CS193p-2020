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
                        withAnimation(Animation.linear(duration: 0.5)) {
                            self.viewModel.choose(card: card)
                        }
                }
                .padding(5)
            }
            Button(action: {
                withAnimation(.linear(duration: 0.5)) {
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
    
    @State private var animatedRemainingBonus: Double = 0

    private func startBonusTimeAnimation(){
        animatedRemainingBonus = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)){
            animatedRemainingBonus = 0
        }
        
    }
    var body: some View{
        GeometryReader{geometry in
            if self.card.isFaceUp || !self.card.isMatched{
                ZStack {
                    Group{
                        if self.card.isConsumingBonusTime{
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-self.animatedRemainingBonus*360-90), clockWise: true)
                                .onAppear(){
                                    self.startBonusTimeAnimation()
                            }
                        }else{
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-self.card.bonusRemaining*360-90), clockWise: true)
                        }
                        
                    }
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

