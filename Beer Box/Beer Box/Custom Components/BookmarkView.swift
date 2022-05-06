//
//  BookmarkView.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 06/05/22.
//

import UIKit

@IBDesignable
class BookmarkView: UIView {
        
    @IBInspectable
    /// The fill color of view
    var fillColor: UIColor = .yellowOcher {
        didSet {
            setupShape()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            // Update layer frame when bounds change
            setupShape()
        }
    }

    /// Create the bookmark shape layer
    private func setupShape() {
        // Reset all added layers
        self.layer.sublayers?.forEach({ layer in
            layer.removeFromSuperlayer()
        })
        // Createh the path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height / 1.2))
        path.addLine(to: CGPoint(x: bounds.width , y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        self.layer.addSublayer(shapeLayer)
    }
}
