//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by 单译 on 2020/6/11.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import Foundation


extension Array where Element: Identifiable{
    
    func firstIndexOf(matching: Element) -> Int?{
        for index in 0..<self.count{
            if self[index].id == matching.id{
            return index
            }
        }
        return nil
    }
    
}
