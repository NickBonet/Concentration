//
//  Concentration.swift
//  Concentration
//
//  Created by Nicholas Bonet on 9/3/20.
//  Copyright © 2020 Nick Bonet. All rights reserved.
//

import Foundation

class Concentration {
    private var numberOfCardsToMatch: Int
    private var cards: CardDeck
    private var cardsSelected: Int {
        get {
            var count = 0
            for card in cardsDealt {
                if card.isSelected { count += 1 }
            }
            return count
        }
    }
    public var cardsDealt = [Card]()
    public var flipCount = 0
    public var currentEmojiTheme = 0
    public var score = 0 {
        didSet {
            if score < 0 { score = 0 }
        }
    }
    
    // TODO: Finish this properly.
    public func chooseCard(at index: Int) {
        assert(cardsDealt.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not valid.")
        
        var card = cardsDealt[index]
        if cardsSelected < numberOfCardsToMatch {
            if !isCardSelected(card) {
                card.wasSeen = true
                card.isSelected = true
                cardsDealt[index] = card
            }
        }
    }
    
    public init(numberOfCardsToMatch: Int, numberOfEmojiThemes: Int) {
        assert(numberOfCardsToMatch == 2 || numberOfCardsToMatch == 3, "Concentration.init(\(numberOfCardsToMatch)): Must have at least one pair of cards.")
        self.numberOfCardsToMatch = numberOfCardsToMatch
        cards = CardDeck(numberOfCardsToMatch: numberOfCardsToMatch)
        resetGame(numberOfEmojiThemes: numberOfEmojiThemes)
    }
    
    public func resetGame(numberOfEmojiThemes: Int) {
        // Reset all necessary variables for new game.
        flipCount = 0
        score = 0
        cardsDealt.removeAll()
        cards = CardDeck(numberOfCardsToMatch: numberOfCardsToMatch)
        cards.shuffle()
        while cardsDealt.count < 20 {
            cardsDealt.append(cards.dealCard()!)
        }
        cards.shuffle()
        currentEmojiTheme = Int.random(in: 1...numberOfEmojiThemes)
    }
    
    public func isCardSelected(_ card: Card) -> Bool {
        return card.isSelected
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return (count == 1) ? self.first : nil
    }
}
