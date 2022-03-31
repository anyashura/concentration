//
//  Card.swift
//  concentration v2
//
//  Created by Anna Shuryaeva on 22.01.2022.
//

import Foundation

struct Card: Hashable, Equatable {

    var isFaceUp = false
    var isMatched = false
    static var identifierFactory = 0

    private var identifier: Int
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }

}
