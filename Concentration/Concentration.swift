//
//  Concentration.swift
//  Concentration
//
//  Created by Nicholas Bonet on 9/3/20.
//  Copyright © 2020 Nick Bonet. All rights reserved.
//

import Foundation

class Concentration {
    
    public var cards = [Card]()
    public var flipCount = 0
    public var currentEmojiTheme = 0
    public var score = 0
    private var indexOfOneAndOnlyFaceUpCard : Int? {
        get {
            return cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly
        }
        
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    public func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not valid.")
        if !cards[index].isMatched && !cards[index].isFaceUp {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if the cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    changeScore(value: 2) // Add score of 2 on match.
                } else { // If the cards do not match, check if they were seen and change score accordingly.
                    if cards[index].wasSeen {
                        changeScore(value: -1)
                    }
                    if cards[matchIndex].wasSeen {
                        changeScore(value: -1)
                    }
                }
                
                // If the cards don't match, mark them as seen.
                cards[index].wasSeen = true
                cards[matchIndex].wasSeen = true
                cards[index].isFaceUp = true
            } else {
                // Either 0 or 2 cards are face up, can flip them all down.
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    public init(numberOfPairsOfCards: Int, numberOfEmojiThemes: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): Must have at least one pair of cards.")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // Choose a random emoji theme to use for the instance of the game.
        currentEmojiTheme = Int.random(in: 1...numberOfEmojiThemes)
        
        // Shuffle the cards in the card array.
        cards.shuffle()
    }
    
    public func resetGame(numberOfPairsOfCards: Int, numberOfEmojiThemes: Int) {
        // Reset all necessary variables for new game.
        flipCount = 0
        score = 0
        
        // Reset the state of all the cards.
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].wasSeen = false
        }
        
        // Reshuffle, and choose a new emoji theme.
        cards.shuffle()
        currentEmojiTheme = Int.random(in: 1...numberOfEmojiThemes)
    }

    // Simple method to modify game score, without dipping into negative values.
    private func changeScore(value: Int) {
        if (value > 0) {
            score += value
        } else {
            if score > 0 { score += value }
        }
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return (count == 1) ? self.first : nil
    }
}
