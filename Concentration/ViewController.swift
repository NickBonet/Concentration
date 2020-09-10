//
//  ViewController.swift
//  Concentration
//
//  Created by Nick Bonet on 8/31/20.
//  Copyright © 2020 Nick Bonet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Text label for the flip count.
    @IBOutlet weak var flipLabel: UILabel!
    
    // Outlet for all of the card buttons in the UI.
    @IBOutlet var cardButtons: [UIButton]!
    
    // Nice little dictionary for different emoji themes for the cards.
    var emojiThemes = [
        1: ["🚗", "🚕", "🚙", "🚒", "🚖", "🚘", "🚚", "🚛"],
        2: ["🍫", "🍬", "🍭", "🍪", "🍩", "🍰", "🧁", "🥮"],
        3: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
        4: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"],
        5: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
        6: ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍"],
    ]
    
    // Instance of the actual game logic class.
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2,
                                  numberOfEmojiThemes: emojiThemes.count)

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
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
    }
    
    func emoji(for card: Card) -> String {
        let currentTheme = emojiThemes[game.currentEmojiTheme]
        return currentTheme?[card.identifier - 1] ?? "?"
    }
}

