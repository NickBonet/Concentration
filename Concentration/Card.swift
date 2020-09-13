//
//  Card.swift
//  Concentration
//
//  Created by Nicholas Bonet on 9/3/20.
//  Copyright © 2020 Nick Bonet. All rights reserved.
//

import Foundation

struct Card {
    
    public var identifier: Int
    public var isFaceUp = false
    public var isMatched = false
    public var wasSeen = false
    
    private static var identifierFactory = 0;
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    public init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
