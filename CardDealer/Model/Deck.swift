//
//  Deck.swift
//  CardDealer
//
//  Created by Micah Chollar on 7/20/19.
//  Copyright © 2019 Widgetilities. All rights reserved.
//

import Foundation

class Deck {
    
    private var cards: [Card] = []
    
    var numberOfCardsInDeck: Int {
        get { return self.cards.count }
    }
    
    func add(card: Card, atTop: Bool = false) {
        
        if atTop {
            cards.insert(card, at: 0)
        } else {
            cards.append(card)
        }
        
    }

    func drawRandomCard() -> Card? {
        
        guard !cards.isEmpty else { return nil }
        
        let index = Int(arc4random()) % cards.count
        let randomCard = cards.remove(at: index)
        return randomCard
        
    }
    
    func removeAllCards() {
        cards.removeAll()
    }
    
    
}
