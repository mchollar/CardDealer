//
//  Card.swift
//  CardDealer
//
//  Created by Micah Chollar on 7/20/19.
//  Copyright © 2019 Widgetilities. All rights reserved.
//

import Foundation

class Card: Equatable {
    
    var contents: String = ""
    var isMatched = false
    var isChosen = false
    
    func match(otherCards: [Card]) -> Int {
        var score = 0
        
        for card in otherCards {
            if card.contents == self.contents {
                score += 1
            }
        }
        return score
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.contents == rhs.contents
    }
}
