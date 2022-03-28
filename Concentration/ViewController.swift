//
//  ViewController.swift
//  concentration v2
//
//  Created by Anna Shuryaeva on 17.01.2022.
//

import UIKit



class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards:numberOfPairsOfCards)
    var numberOfPairsOfCards : Int {
            return (cardButtons.count + 1) / 2
    }
    
    private var emoji = [Card : String]()
    
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var Score: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    private struct themeOfGame {
        var nameOfTheme : String
        var emojies : [String]
        var backroundColor : UIColor
        var cardColor : UIColor
    }

    private let allThemes : [themeOfGame] = [
        themeOfGame(
            nameOfTheme : "Transport",
            emojies : ["🚗", "🚖", "🛺", "🚤", "🦼", "✈️", "🪝","🏍"],
            backroundColor : .blue,
            cardColor : .darkGray),
        themeOfGame(
            nameOfTheme : "Insects",
            emojies : ["🪰", "🪲", "🦟", "🕷", "🐞", "🐛", "🦋","🐝"],
            backroundColor : .green,
            cardColor : .yellow),
        themeOfGame(
            nameOfTheme : "Figures",
            emojies : ["💟", "🈶", "🉐", "❇️", "🏧", "1️⃣", "🟪", "🟨"],
            backroundColor : .systemPink,
            cardColor : .systemIndigo),
        themeOfGame(
            nameOfTheme : "Any",
            emojies : ["⚒", "💣", "🔫", "💊", "🧬", "🦠", "🚬", "⏱"],
            backroundColor : .purple,
            cardColor : .systemMint),
        themeOfGame(
            nameOfTheme : "Fruits",
            emojies : ["🥑", "🥭", "🌶", "🍌", "🥥", "🥝", "🌽","🥕"],
            backroundColor : .orange,
            cardColor : .purple),
        themeOfGame(
            nameOfTheme : "Flags",
            emojies : ["🏴", "🏁", "🇦🇲", "🇨🇲", "🇨🇬", "🇰🇾", "🇨🇮", "🇩🇪"],
            backroundColor : .magenta,
            cardColor : .brown),
        themeOfGame(
            nameOfTheme : "Smiles",
            emojies : ["😀", "🥶", "🤬", "😈", "👹", "🤢", "🤖", "🤡"],
            backroundColor : .gray,
            cardColor : .red)
    ]

    private lazy var currentTheme = allThemes.randomElement()!
    private lazy var emojiChoices = currentTheme.emojies
    
    @IBAction private func newGame(_ sender: UIButton) {
        emoji = [Card : String]()
        currentTheme = allThemes.randomElement()!
        emojiChoices = currentTheme.emojies
        updateTheme()
        game.flipCount = 0
        game.startNewGame()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateTheme() {
        flipCountLabel.textColor = currentTheme.cardColor
        titleLabel.text = currentTheme.nameOfTheme
        titleLabel.textColor = currentTheme.cardColor
        view.backgroundColor = currentTheme.backroundColor
        Score.textColor = currentTheme.cardColor
        newGameButton.setTitle("New game", for: .normal)
        newGameButton.backgroundColor = currentTheme.cardColor
        newGameButton.setTitleColor(currentTheme.backroundColor, for: .normal)
    }
        
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for : card), for: UIControl.State.normal)
                button.setAttributedTitle(attributedName(for: card, fontSize: 28.0), for: .normal)
                button.backgroundColor =  UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.setAttributedTitle(NSAttributedString(""), for: UIControl.State.normal)
                button.backgroundColor =  card.isMatched ? UIColor.clear : currentTheme.cardColor
            }
            Score.text = "Score: \(game.score)"
            updateTheme()
            flipCountLabel.text = "Flips: \(game.flipCount)"
        }
    }
    
    private func attributedName (for card: Card, fontSize: CGFloat) -> NSAttributedString {
        let attributes : [NSAttributedString.Key : Any] = [
            .font : UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)]

        return NSAttributedString(string: emoji(for: card), attributes: attributes)
    }
  
    private func emoji(for card : Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
    override func viewDidLoad() {
        updateViewFromModel()
    }
}

extension Int {
    var arc4random : Int {
        if self > 0 {
            return(Int(arc4random_uniform(UInt32(self))))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs((self)))))
        } else {
            return 0
        }
    }
}
