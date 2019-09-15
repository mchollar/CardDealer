//
//  SorryCard.swift
//  CardDealer
//
//  Created by Micah Chollar on 7/20/19.
//  Copyright © 2019 Widgetilities. All rights reserved.
//

import Foundation

class SorryCard: Card {
    
    var number: Int
    var text: String
    
    init(pair: (number: Int, text: String)) {
        self.number = pair.number
        self.text = pair.text
    }

    class func validPairs() -> [(Int, String)] {
        return [
        (0, "Sorry\nMove from Start and switch places with an opponent, whome you bump back to Start."),
        (1, "Move from Start or move forward 1."),
        (2, "Move from Start or move forward 2.\nDraw Again."),
        (3, "Move forward 3."),
        (4, "Move backward 4."),
        (5, "Move forward 5."),
        (7, "Move forward 7 or split between two pawns."),
        (8, "Move forward 8."),
        (10, "Move forward 10 or move backward 1."),
        (11, "Move forward 11 or change places with an opponent."),
        (12, "Move forward 12.")
        ]
    }
    
}
