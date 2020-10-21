//
//  EmojiMemoryGame.swift
//  SwiftTest
//
//  Created by 叶锦浩 on 2020/9/25.
//  Copyright © 2020 叶锦浩. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>

    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.getEmojiArray().count) { index in theme.getEmojiArray()[index] }
    }

    init() {
        themeOfGame = EmojiMemoryGame.randomTheme()
        model = EmojiMemoryGame.createMemoryGame(theme: themeOfGame)
    }
    
    static func randomTheme() -> Theme {
        // 选出随机的主题
        let randomTheme = Int.random(in: 0 ..< Theme.allCases.count)
        var index = 0
        for theme in Theme.allCases {
            if index == randomTheme {
                return theme
            }
            index += 1
        }
        return Theme.ball
    }
    
    var themeOfGame:Theme

    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }

    var goals: Int {
        return model.goals
    }

    var name: String {
        return themeOfGame.rawValue
    }

    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }

    func newGame() {
        themeOfGame = EmojiMemoryGame.randomTheme()
        model = EmojiMemoryGame.createMemoryGame(theme: themeOfGame)
    }

    enum Theme: String, CaseIterable {
        case ball = "Ball", face = "Face", family = "Family", clothe = "Clothe", instrument = "Instrument"
        func getEmojiArray() -> [String] {
            switch self {
            case .ball:
                return ["⚽️", "🏀", "🏈", "⚾️", "🏐", "🎱"]
            case .clothe:
                return ["👕", "🥼", "🩳", "👙", "👘", "👗"]
            case .family:
                return ["👴🏿", "🧓🏻", "👱🏽‍♂️", "👶🏾", "👧", "👱🏼‍♀️"]
            case .face:
                return ["😫", "😳", "🤪", "🤬", "🤔", "🤮"]
            case .instrument:
                return ["🥁", "🎷", "🎸", "🪕", "🎻", "🎤"]
            }
        }
        func getColor() -> Color {
            switch self {
            case .ball:
                return Color.black
            case .clothe:
                return Color.blue
            case .family:
                return Color.yellow
            case .face:
                return Color.orange
            case .instrument:
                return Color.pink
            }
        }
    }
}
