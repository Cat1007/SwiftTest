//
//  MemoryGame.swift
//  SwiftTest
//
//  Created by 叶锦浩 on 2020/9/25.
//  Copyright © 2020 叶锦浩. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    var goals: Int = 0
    var theOnlyChosenOne: Int? {
        set {
            for index in cards.indices { cards[index].isFaceUp = index == newValue }
        }
        get {
            var faceUpIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpIndices.append(index)
                }
            }
            if faceUpIndices.only() {
                return faceUpIndices[0]
            } else {
                return nil
            }
        }
    }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(content: cardContentFactory(pairIndex), id: pairIndex*2))
            cards.append(Card(content: cardContentFactory(pairIndex), id: pairIndex*2 + 1))
        }
        cards.shuffle()
    }

    mutating func choose(card: Card) {
        // 选择有效的卡片
        if let chosenIndex = cards.firstIndex(matching: card),!cards[chosenIndex].isFaceUp,!cards[chosenIndex].isMatched {
            // 判断现在有没有待匹配的卡片
            if let potentialMatchIndex = theOnlyChosenOne {
                // 内容相同 进行匹配
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    goals += 2
                } else {
                    // 内容不同 标示为已被查看 并记分
                    if cards[potentialMatchIndex].isInvolved {
                        goals -= 1
                    } else {
                        cards[potentialMatchIndex].isInvolved = true
                    }
                    if cards[chosenIndex].isInvolved {
                        goals -= 1
                    } else {
                        cards[chosenIndex].isInvolved = true
                    }
                }
            } else {
                // 设置为第一张卡片
                theOnlyChosenOne = chosenIndex
            }
            // 翻转所选卡片
            cards[chosenIndex].isFaceUp = true
        }
    }

    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var isInvolved: Bool = false
    }
}
