//
//  ViewController.swift
//  concentration v2
//
//  Created by Anna Shuryaeva on 17.01.2022.
//

import UIKit

class ViewController: UIViewController {

    enum Constant {
        static let fontSize = 28.0
        static let numberOfPairsOfCards = 8
    }

    private lazy var game = Concentration(numberOfPairsOfCards: Constant.numberOfPairsOfCards)

    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var score: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        newGameButton.setTitle("New game", for: .normal)
        updateThemeColor()
    }

    @IBAction private func newGame(_ sender: UIButton) {
        game.startNewGame()
        updateThemeColor()
        updateViewFromModel()
        _ = cardButtons.map { $0.isEnabled = true }
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }

    private func updateThemeColor() {
        // берём данные из Источника, который знает как выглядят темы – легко заменить
        flipCountLabel.textColor = game.currentTheme.cardColor
        titleLabel.textColor = game.currentTheme.cardColor
        view.backgroundColor = game.currentTheme.backroundColor
        score.textColor = game.currentTheme.cardColor
        newGameButton.backgroundColor = game.currentTheme.cardColor
        newGameButton.setTitleColor(game.currentTheme.backroundColor, for: .normal)
        titleLabel.text = game.currentTheme.nameOfTheme
    }

    private func updateViewFromModel() {

        for index in cardButtons.indices {
            let button = cardButtons[index]
            var card = game.cards[index]
            if card.isFaceUp {
                card.title = game.emoji(for: card)
//                button.setTitle(card.title, for: .normal)
                button.setAttributedTitle(title(for: card.title, fontSize: Constant.fontSize), for: .normal)
                button.backgroundColor =  UIColor.white
                button.isEnabled = false
            } else {
                button.setTitle("", for: .normal)
                button.setAttributedTitle(NSAttributedString(""), for: .normal)
                button.isEnabled = true

                button.backgroundColor = card.isMatched ? .clear : game.currentTheme.cardColor
                button.isEnabled = card.isMatched ? false : true
            }

            score.text = "Score: \(game.score)"
            flipCountLabel.text = "Flips: \(game.flipCount)"
        }
    }

    private func title(for emoji: String, fontSize: CGFloat) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        ]
        return NSAttributedString(string: emoji, attributes: attributes)
    }
}
