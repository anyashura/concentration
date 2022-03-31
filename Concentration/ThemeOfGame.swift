//
//  ThemeOfGame.swift
//  Concentration
//
//  Created by Anna Shuryaeva on 31.03.2022.
//

import UIKit

struct ThemeOfGame {
    var nameOfTheme: String
    var emojies: [String]
    var backroundColor: UIColor
    var cardColor: UIColor
}

let allThemes: [ThemeOfGame] = [
    ThemeOfGame(
        nameOfTheme: "Transport",
        emojies: ["🚗", "🚖", "🛺", "🚤", "🦼", "✈️", "🪝", "🏍"],
        backroundColor: .blue,
        cardColor: .darkGray),
    ThemeOfGame(
        nameOfTheme: "Insects",
        emojies: ["🪰", "🪲", "🦟", "🕷", "🐞", "🐛", "🦋", "🐝"],
        backroundColor: .green,
        cardColor: .yellow),
    ThemeOfGame(
        nameOfTheme: "Figures",
        emojies: ["💟", "🈶", "🉐", "❇️", "🏧", "1️⃣", "🟪", "🟨"],
        backroundColor: .systemPink,
        cardColor: .systemIndigo),
    ThemeOfGame(
        nameOfTheme: "Any",
        emojies: ["⚒", "💣", "🔫", "💊", "🧬", "🦠", "🚬", "⏱"],
        backroundColor: .purple,
        cardColor: .systemMint),
    ThemeOfGame(
        nameOfTheme: "Fruits",
        emojies: ["🥑", "🥭", "🌶", "🍌", "🥥", "🥝", "🌽", "🥕"],
        backroundColor: .orange,
        cardColor: .purple),
    ThemeOfGame(
        nameOfTheme: "Flags",
        emojies: ["🏴", "🏁", "🇦🇲", "🇨🇲", "🇨🇬", "🇰🇾", "🇨🇮", "🇩🇪"],
        backroundColor: .magenta,
        cardColor: .brown),
    ThemeOfGame(
        nameOfTheme: "Smiles",
        emojies: ["😀", "🥶", "🤬", "😈", "👹", "🤢", "🤖", "🤡"],
        backroundColor: .gray,
        cardColor: .red)
]
