//
//  Card.swift
//  concentration v2
//
//  Created by Anna Shuryaeva on 22.01.2022.
//

import Foundation

struct Card {

    var isFaceUp = false
    var isMatched = false
    private static var identifierFactory = 0

    private var identifier: Int
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }

    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
}

 extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
 }

 extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
 }
