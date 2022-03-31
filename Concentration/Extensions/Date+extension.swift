//
//  Date+extension.swift
//  Concentration
//
//  Created by Anna Shuryaeva on 31.03.2022.
//

import Foundation

extension Date {

    var sinceNow: Int {
        return -Int(self.timeIntervalSinceNow)
    }
}
