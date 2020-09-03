//
//  ViewController.swift
//  Concentration
//
//  Created by Nick Bonet on 8/31/20.
//  Copyright © 2020 Nick Bonet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: Concentration
    
    @IBOutlet weak var flipLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var flipCount = 0 {
        didSet {
            flipLabel.text = "Flips:   \(flipCount)"
        }
    }
    
    let emojiTheme = ["🚗", "🚕", "🚙", "🚒"]

    @IBAction func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.firstIndex(of: sender)!
        flipCard(withEmoji: emojiTheme[cardNumber], on: sender)
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        flipCount += 1
    }
    
}

