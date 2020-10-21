//
//  EmojiMemoryGameView.swift
//  SwiftTest
//
//  Created by 叶锦浩 on 2020/9/16.
//  Copyright © 2020 叶锦浩. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        HStack {
            Text("Goal: \(viewModel.goals)")
            Spacer()
            Text("\(viewModel.name)")
            Spacer()
            Button("New Game") {
                viewModel.newGame()
            }
        }
        .padding()
        Grid(items: viewModel.cards) { card in
            Card(card: card, color: viewModel.themeOfGame.getColor()).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
        }
        .foregroundColor(viewModel.themeOfGame.getColor())
        .padding()
    }
}

struct Card: View {
    var card: MemoryGame<String>.Card
    var color: Color

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: conerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                        .font(Font.system(size: FontSize(for: geometry.size)))
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: 10.0).fill()
                    }
                }
            }
        }
    }

    let conerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    func FontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
