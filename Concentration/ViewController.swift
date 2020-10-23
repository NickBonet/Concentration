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
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var twoCardButton: UIButton!
    @IBOutlet weak var threeCardButton: UIButton!
    
    // Changes when one of the new game buttons is pressed, then sent to model.
    private var cardsToMatch = 2
    
    /*
        Nice little dictionary for different emoji themes for the cards.
        Can simply add a new entry of 8 emojis and it will be randomly
        selected by the game.
    */
    private var emojiThemes = [
        1: ["🚗", "🚕", "🚙", "🚒", "🚖", "🚘", "🚚", "🚛", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
        //2: ["🍫", "🍬", "🍭", "🍪", "🍩", "🍰", "🧁", "🥮"],
        //3: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
        //4: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"],
        //5: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
        //6: ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍"],
    ]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        twoCardButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        twoCardButton.layer.borderWidth = 1
        threeCardButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        threeCardButton.layer.borderWidth = 1
        updateViewFromModel()
    }
    
    // Instance of the actual game logic class.
    private lazy var game = Concentration(numberOfCardsToMatch: cardsToMatch,
                                          numberOfEmojiThemes: emojiThemes.count)

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        if sender.tag == 2 { cardsToMatch = 2 }
        else if sender.tag == 3 {
            cardsToMatch = 3
        }
        game.resetGame(numberOfCardsToMatch: cardsToMatch, numberOfEmojiThemes: emojiThemes.count)
        for button in cardButtons {
            button.isHidden = false
        }
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if game.cardsDealt.indices.contains(index) {
                let card = game.cardsDealt[index]
                if game.isCardSelected(card) {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                }
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                button.isHidden = true
            }
        }
        updateScoreLabel()
        updateFlipCountLabel()
    }
    
    private func updateFlipCountLabel() {
        flipLabel.text = "Flips: \(game.flipCount)"
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func emoji(for card: Card) -> String {
        /*
            Returns an emoji based on the selected theme in game's currentEmojiTheme
            Since the cards are shuffled AND a random theme is chosen in the game's init()
            method, I don't bother to select emojis randomly here.
        */
        return emojiThemes[game.currentEmojiTheme]?[card.identifier] ?? "?"
    }
}
