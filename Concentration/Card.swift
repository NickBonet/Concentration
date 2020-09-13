//
//  Card.swift
//  Concentration
//
//  Created by Nicholas Bonet on 9/3/20.
//  Copyright © 2020 Nick Bonet. All rights reserved.
//

import Foundation

struct Card {
    
    var identifier: Int
    var isFaceUp = false
    var isMatched = false
    var wasSeen = false
    
    private static var identifierFactory = 0;
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
