//
//  ViewController.swift
//  CardDealer
//
//  Created by Micah Chollar on 7/20/19.
//  Copyright © 2019 Widgetilities. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var deckView: UIView!
    
    var sorryDeck = SorryDeck()
    var topCardView: SorryCardView?
    var bottomCardView: SorryCardView?
    
    var firstCardBeingPlayed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        dealNewDeck()
    }
    
    @IBAction func newDeckTouched(_ sender: UIButton) {
        dealNewDeck()
    }
    
    func dealNewDeck() {
        for view in deckView.subviews {
            view.removeFromSuperview()
        }
        
        firstCardBeingPlayed = true
        sorryDeck.newDeck()
        
        topCardView = SorryCardView(frame: CGRect(x: 0, y: 0, width: deckView.bounds.width, height: deckView.bounds.height))
        bottomCardView = SorryCardView(frame: CGRect(x: 0, y: 0, width: deckView.bounds.width, height: deckView.bounds.height))
        
        deckView.addSubview(bottomCardView!)
        deckView.addSubview(topCardView!)
        
        topCardView?.card = sorryDeck.drawRandomCard() as? SorryCard
        bottomCardView?.card = sorryDeck.drawRandomCard() as? SorryCard
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cardTouched(_:)))
        topCardView?.addGestureRecognizer(tapRecognizer)

    }
    
    @objc func cardTouched(_ sender: UITapGestureRecognizer) {
        
        guard let topCardView = topCardView else {
            return
        }
        
        
        if firstCardBeingPlayed {
            // Just flip it over and we're done
            UIView.transition(with: topCardView,
                              duration: 0.3,
                              options: .transitionFlipFromLeft,
                              animations: {
                topCardView.isFaceUp = true
            },
                              completion: nil)
            firstCardBeingPlayed = false
            return
        }
        
        
        // Flip the bottom card and move the top card off to the side
        
        bottomCardView?.isFaceUp = true
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
            topCardView.center.x += topCardView.bounds.size.width + 100
        }
        
        // Then move the old top cardView back in place and set it up to be the next card, while giving the bottom cardView a new card drawn from the deck. If the deck didn't return a new card, remove the bottom cardView. If there is no bottom cardView, just remove the top card.
        
        animator.addCompletion{ [unowned self] (position) in
            topCardView.frame.origin = .zero
            
            if let bottomCardView = self.bottomCardView {
                topCardView.card = bottomCardView.card
                bottomCardView.card = self.sorryDeck.drawRandomCard() as? SorryCard
                if bottomCardView.card == nil {
                    bottomCardView.removeFromSuperview()
                    self.bottomCardView = nil
                }
            } else {
                topCardView.removeFromSuperview()
            }
            
        }
        animator.startAnimation()
        
        
    }
}
    
    


