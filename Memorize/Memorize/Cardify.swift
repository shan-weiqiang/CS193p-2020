//
//  Cardify.swift
//  Memorize
//
//  Created by 单译 on 2020/6/18.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier{
    
    var isFaceUp: Bool{
        rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0:180
    }
    var rotation: Double

    var animatableData: Double{
        get{rotation}
        set{rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1:0)
            
            RoundedRectangle(cornerRadius: self.cornerRadius).fill()
            .opacity(isFaceUp ? 0:1)
            
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
        
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
}


extension View{
    
    func cardify(isFaceUp: Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))
        
    }
}
