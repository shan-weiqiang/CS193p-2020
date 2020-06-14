//
//  Array+Only.swift
//  Memorize
//
//  Created by 单译 on 2020/6/14.
//  Copyright © 2020 schmessi@163.com.shan.weiqiang. All rights reserved.
//

import Foundation

extension Array{
    var only: Element?{
        self.count == 1 ? self.first : nil
    }
}
