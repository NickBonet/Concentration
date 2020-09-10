//
//  ViewController.swift
//  Concentration
//
//  Created by Nick Bonet on 8/31/20.
//  Copyright © 2020 Nick Bonet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var flipLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    
    // Nice little dictionary for different emoji themes for the cards.
    private var emojiThemes = [
        1: ["🚗", "🚕", "🚙", "🚒", "🚖", "🚘", "🚚", "🚛"],
        2: ["🍫", "🍬", "🍭", "🍪", "🍩", "🍰", "🧁", "🥮"],
        3: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
        4: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"],
        5: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
        6: ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍"],
    ]
    
    // Instance of the actual game logic class.
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2,
                                          numberOfEmojiThemes: emojiThemes.count)

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game.resetGame(numberOfPairsOfCards: (cardButtons.count+1)/2,
                       numberOfEmojiThemes: emojiThemes.count)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
        }
        flipLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func emoji(for card: Card) -> String {
        return emojiThemes[game.currentEmojiTheme]?[card.identifier - 1] ?? "?"
    }
}

