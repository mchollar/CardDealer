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
    var isFaceUp = false { didSet { setNeedsDisplay() } }
    
    // Appearance Constants
    let CORNER_RADIUS = CGFloat(12.0)
    let NUMBER_FONT_SCALE_FACTOR = CGFloat(4)
    let TEXT_FONT_SCALE_FACTOR = CGFloat(1.2)
    let MIDDLE_FONT_SCALE_FACTOR = CGFloat(8)
    let CORNER_OFFSET = CGFloat(24.0)
    
    let cardColor = UIColor.white
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = nil
        self.isOpaque = false
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        
    }
    
    override func draw(_ rect: CGRect) {
        
        drawCardBackground()
        
        if isFaceUp {
            drawFaceUp()
        } else {
            drawFaceDown()
        }
        
    }
    
    private func drawCardBackground() {
        
        let roundedRect = UIBezierPath(roundedRect: self.bounds,
                                       cornerRadius: CORNER_RADIUS)
        
        self.layer.cornerRadius = CORNER_RADIUS
        
        cardColor.setFill()
        roundedRect.fill()
    }

    
    private func drawFaceUp() {
        
        guard let card = card else { return }
        let numberString = card.number == 0 ? "" : "\(card.number)"
        let text = card.text
        
        let tempFont = UIFont.preferredFont(forTextStyle: .body)
        let textFont = tempFont.withSize(tempFont.pointSize * TEXT_FONT_SCALE_FACTOR)
        let numberFont = tempFont.withSize(tempFont.pointSize * NUMBER_FONT_SCALE_FACTOR)
        let middleFont = tempFont.withSize(tempFont.pointSize * MIDDLE_FONT_SCALE_FACTOR)
        
        let cornerNumberText = NSAttributedString(string: numberString, attributes: [.font : numberFont])
        let descriptionText = NSAttributedString(string: text, attributes: [.font : textFont])
        
        let cornerOrigin = CGPoint(x: CORNER_OFFSET, y: CORNER_OFFSET)
        let cornerSize = cornerNumberText.size()
        var textOrigin = cornerOrigin
        textOrigin.x += cornerSize.width + 20.0
        let textSize = CGSize(width: self.bounds.size.width - ((CORNER_OFFSET * 2) + cornerSize.width + 20.0), height: self.bounds.size.height / 4.0)
        drawText(attrString: cornerNumberText, at: cornerOrigin, size: cornerSize)
        drawText(attrString: descriptionText, at: textOrigin, size: textSize)
        
        // Draw the number (or Sorry) in the middle
        if card.number == 0 {
            // Draw Sorry in middle
            if let image = UIImage(named: "sorry_logo") {
                let imageSize = CGSize(width: self.bounds.size.width - (CORNER_OFFSET * 4), height: self.bounds.size.height / 7)
                let imageOrigin = CGPoint(x: CORNER_OFFSET * 2, y: self.bounds.midY - (imageSize.height / 2))
                image.draw(in: CGRect(origin: imageOrigin, size: imageSize))
            }
            
        } else {
            
            let middleString = numberString
            let middleNumberText = NSAttributedString(string: middleString, attributes: [.font : middleFont])
            let middleTextSize = middleNumberText.size()
            let textX = (self.bounds.width / 2) - (middleTextSize.width / 2)
            let textY = (self.bounds.height / 2) - (middleTextSize.height / 2)
            let middleTextBounds = CGRect(origin: CGPoint(x: textX, y: textY), size: middleTextSize)
            middleNumberText.draw(in: middleTextBounds)
        }
        
    }
    
    private func drawFaceDown() {
        
        if let image = UIImage.init(named: "sorry_logo"),
        let rotatedImage = image.rotate(radians: .pi / 2) {
            
            let imageSize = CGSize(width: self.bounds.size.width - (CORNER_OFFSET * 4), height: self.bounds.size.height - (CORNER_OFFSET * 2))
            let imageOrigin = CGPoint(x: CORNER_OFFSET * 2, y: CORNER_OFFSET)
            
            let imageBounds = CGRect(origin: imageOrigin, size: imageSize)
            rotatedImage.draw(in: imageBounds)
        }
       
    }
    
    
    func drawText(attrString: NSAttributedString, at origin: CGPoint, size: CGSize) {
        var textBounds = CGRect()
        textBounds.origin = origin
        textBounds.size = size
        attrString.draw(in: textBounds)
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: bounds.size.width, y: bounds.size.height)
        context?.rotate(by: .pi)
        attrString.draw(in: textBounds)
    }

}


extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
    
//    func resized(withPercentage percentage: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//    
//    func resized(toWidth width: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
}
