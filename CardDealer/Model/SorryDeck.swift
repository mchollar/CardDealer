//
//  SorryDeck.swift
//  CardDealer
//
//  Created by Micah Chollar on 7/20/19.
//  Copyright © 2019 Widgetilities. All rights reserved.
//

import Foundation

class SorryDeck: Deck {
    
    override init() {
        super.init()
        newDeck()
    }
    
    func newDeck() {
        super.removeAllCards()
        for i in 0 ..< SorryCard.validPairs().count {
            let newPair = SorryCard.validPairs()[i]
            let newCard = SorryCard(pair: newPair)
            for _ in 0 ..< 4 {
                add(card: newCard)
            }
            if i == 1 {
                add(card: newCard)
            }
        }
    }
    
}
