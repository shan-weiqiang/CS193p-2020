//
//  Cardify.swift
//  Memorize
//
//  Created by 单译 on 2020/6/18.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier{
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        
        ZStack{
            if isFaceUp{
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                content
                
            }else{
                RoundedRectangle(cornerRadius: self.cornerRadius).fill()
            }
        }
        
        
        
        
        
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
}


extension View{
    
    func cardify(isFaceUp: Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))
        
    }
}
