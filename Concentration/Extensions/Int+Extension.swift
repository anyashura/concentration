//
//  Int+Extension.swift
//  Concentration
//
//  Created by Anna Shuryaeva on 31.03.2022.
//

import Foundation

extension Int {
    var arc4random: Int {
        if self > 0 {
            return(Int(arc4random_uniform(UInt32(self))))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs((self)))))
        } else {
            return 0
        }
    }
}
