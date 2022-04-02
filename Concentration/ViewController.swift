//
//  ViewController.swift
//  concentration v2
//
//  Created by Anna Shuryaeva on 17.01.2022.
//

import UIKit

class ViewController: UIViewController {

    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var emoji = [Card: String]()
    private lazy var currentTheme = allThemes.randomElement()!
    private lazy var emojiChoices = currentTheme.emojies
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var score: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.setTitle("New game", for: .normal)
        updateThemeColor()
        updateTitle()
        updateViewFromModel()
    }

    @IBAction private func newGame(_ sender: UIButton) {
        emoji.removeAll()
        currentTheme = allThemes.randomElement()!
        emojiChoices = currentTheme.emojies
        updateThemeColor()
        updateTitle()
        game.startNewGame()
        updateViewFromModel()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.isEnabled = true
        }
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }

    private func updateThemeColor() {
        flipCountLabel.textColor = currentTheme.cardColor
        titleLabel.textColor = currentTheme.cardColor
        view.backgroundColor = currentTheme.backroundColor
        score.textColor = currentTheme.cardColor
        newGameButton.backgroundColor = currentTheme.cardColor
        newGameButton.setTitleColor(currentTheme.backroundColor, for: .normal)
    }

    private func updateTitle() {
        titleLabel.text = currentTheme.nameOfTheme
    }

    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.setAttributedTitle(attributedName(for: card, fontSize: Constant.fontSize), for: .normal)
                button.backgroundColor =  UIColor.white
                button.isEnabled = false
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.setAttributedTitle(NSAttributedString(""), for: .normal)
                button.isEnabled = true
                if card.isMatched {
                    button.backgroundColor = UIColor.clear
                    button.isEnabled = false
                } else {
                    button.backgroundColor = currentTheme.cardColor
                }
            }
            score.text = "Score: \(game.score)"
            flipCountLabel.text = "Flips: \(game.flipCount)"
        }
    }

    private func attributedName (for card: Card, fontSize: CGFloat) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        ]
        return NSAttributedString(string: emoji(for: card), attributes: attributes)
    }

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }

    enum Constant {
       static let fontSize = 28.0
    }

}
