//
//  Concentration.swift
//  Concentration
//
//  Created by Nicholas Bonet on 9/3/20.
//  Copyright © 2020 Nick Bonet. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var flipCount = 0
    var currentEmojiTheme = 0
    
    func chooseCard(at index: Int) {
        flipCount += 1
        print("Card number \(cards[index].identifier) clicked")
        
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int, numberOfEmojiThemes: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // Choose a random emoji theme to use for the instance of the game.
        currentEmojiTheme = Int.random(in: 1...numberOfEmojiThemes)
        
        // Shuffle the cards in the card array.
        cards.shuffle()
    }
    
}
