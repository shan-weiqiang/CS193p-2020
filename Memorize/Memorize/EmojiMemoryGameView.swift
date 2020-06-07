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
        HStack{
            ForEach(viewModel.cards){ card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
        
        .padding()
        .foregroundColor(Color.orange)
        
    }
}
 





struct CardView: View{
    
    var card: MemoryGame<String>.Card
    var body: some View{
        
        GeometryReader{geometry in
            ZStack {
                if self.card.isFaceUp{
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                    Text(self.card.content)

                }else{
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill()
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
