//
//  Concentration model.swift
//  concentration v2
//
//  Created by Anna Shuryaeva on 22.01.2022.
//

import Foundation

final class Concentration {

    enum ScoreCount: Int {
        case penalty = 10
        case win = 20
    }

    var theme = Themes()
    var score = 0
    var facedCards = [Int]()
    var flipCount = 0
    var emojies = [Card: String]()
    var currentTheme = Themes().defaultTheme
    lazy var emojiChoices = currentTheme.emojies

    private var dateClick: Date?
    private var timePenalty: Int {
        return min(-Int(dateClick?.timeIntervalSinceNow ?? 0), ScoreCount.penalty.rawValue)
    }
    private (set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            foundIndex()
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    func startNewGame() {
        flipCount = 0
        score = 0
        facedCards.removeAll()
        emojies.removeAll()
        currentTheme = Themes().allThemes.randomElement() ?? Themes().defaultTheme
        emojiChoices = currentTheme.emojies
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        cards.shuffle()
    }

    func chooseCard (at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not in cards" )
        flipCount += 1
        guard !cards[index].isMatched else { return indexOfOneAndOnlyFaceUpCard = index }
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            if cards[matchIndex] == cards[index] {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                score += ScoreCount.win.rawValue
            } else {
                if facedCards.contains(index) {
                    score -= ScoreCount.penalty.rawValue
                }
                if facedCards.contains(matchIndex) {
                    score -= ScoreCount.penalty.rawValue
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

    func emoji(for card: Card) -> String {

        if emojies[card] == nil, emojiChoices.count > 0 {
            emojies[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emojies[card] ?? "?"
    }

    private func foundIndex() -> Int? {
        var foundIndex: Int?
        for index in cards.indices {
            guard cards[index].isFaceUp else { continue }
            if foundIndex == nil {
                foundIndex = index
            } else {
                return nil
            }
        }
        return foundIndex
    }

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : must have at least one pair of card")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }

}
