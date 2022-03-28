//
//  Concentration model.swift
//  concentration v2
//
//  Created by Anna Shuryaeva on 22.01.2022.
//

import Foundation

class Concentration {
    private (set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex : Int? = nil
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var score = 0
    var facedCards = [Int]()
    var flipCount = 0
    var dateClick : Date?
    var timePenalty : Int {
        return min(dateClick?.sinceNow ?? 0, 10)
    }
    
    func startNewGame() {
        score = 0
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        cards.shuffle()
        facedCards = []
    }
    
    func chooseCard (at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : choosen index not in cards" )
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 20
                } else {
                    if facedCards.contains(index) {
                        score -= 10
                    }
                    if facedCards.contains(matchIndex) {
                        score -= 10
                    }
                    facedCards.append(index)
                    facedCards.append(matchIndex)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            score -= timePenalty
            dateClick = Date()
        }
    }
    
    init(numberOfPairsOfCards : Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : must have at least one pair of card")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
}

extension Date {
    var sinceNow : Int {
        return -Int(self.timeIntervalSinceNow)
    }
}

