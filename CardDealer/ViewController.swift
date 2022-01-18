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
        
        guard let topCardView = topCardView else { return }
        
        if firstCardBeingPlayed {
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
        
        // If it's already faceup, then proceed to move it to the bottom and flip the old bottom while moving it to the top
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn, animations: nil)
        
        animator.addAnimations { [unowned self] in
            topCardView.center.x += topCardView.bounds.size.width + 100
            self.bottomCardView?.isFaceUp = true
        }
        
        animator.addCompletion{ [unowned self] (position) in
            topCardView.frame.origin = .zero
            if self.bottomCardView != nil {
                topCardView.card = self.bottomCardView!.card
            } else {
                topCardView.removeFromSuperview()
                return
            }
            self.bottomCardView?.isFaceUp = false
        
                self.bottomCardView?.card = self.sorryDeck.drawRandomCard() as? SorryCard
                if self.bottomCardView != nil, self.bottomCardView!.card == nil {
                    self.bottomCardView?.removeFromSuperview()
                    self.bottomCardView = nil
                }
        }
        animator.startAnimation()
        
        
    }
}
    
    


