//
//  SorryCardView.swift
//  CardDealer
//
//  Created by Micah Chollar on 7/20/19.
//  Copyright © 2019 Widgetilities. All rights reserved.
//

import UIKit

class SorryCardView: UIView {

    var card: SorryCard? { didSet { setNeedsDisplay() } }
    var number: Int? { didSet { setNeedsDisplay() } }
    var text: String? { didSet { setNeedsDisplay() } }
    var isFaceUp = false { didSet { setNeedsDisplay() } }
    
    var labelStackView = UIStackView()
    var numberLabel = UILabel()
    var textLabel = UILabel()
    
    // Appearance Constants
    let CORNER_RADIUS = CGFloat(12.0)
    let NUMBER_FONT_SCALE_FACTOR = CGFloat(0.4)
    let TEXT_FONT_SCALE_FACTOR = CGFloat(0.1)
    let cardColor = UIColor(red: 0.953, green: 0.941, blue: 0.820, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func setup() {
        self.backgroundColor = nil
        self.isOpaque = false
        
        self.addSubview(labelStackView)
        numberLabel.textAlignment = .center
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        
        labelStackView.addArrangedSubview(numberLabel)
        labelStackView.addArrangedSubview(textLabel)
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        
        //Now add shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        
    }
    
    override func draw(_ rect: CGRect) {
      
        guard let card = card else { return }
        
        let roundedRect = UIBezierPath(roundedRect: self.bounds,
                                       cornerRadius: CORNER_RADIUS)
        
        self.layer.cornerRadius = CORNER_RADIUS
        
        cardColor.setFill()
        roundedRect.fill()
        
        if isFaceUp {
            number = card.number
            text = card.text
        } else {
            number = -1
            text = ""
        }
        
        if let number = self.number, number > 0 {
            numberLabel.text = "\(number)"
        } else {
            numberLabel.text = ""
        }
        textLabel.text = self.text
        
        textLabel.font = textLabel.font.withSize(textLabel.frame.size.height * TEXT_FONT_SCALE_FACTOR)
        numberLabel.font = numberLabel.font.withSize(textLabel.frame.size.height * NUMBER_FONT_SCALE_FACTOR)
        
        labelStackView.frame.size = self.frame.size
        
        textLabel.textColor = .black
        numberLabel.textColor = .black
        
        textLabel.transform = CGAffineTransform.init(rotationAngle: .pi/2)
        
        
        
    }
    

}
