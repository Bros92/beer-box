//
//  RoundedView.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 08/05/22.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    /// The mask layer to round the specific corners
    private var cornerMask: CAShapeLayer?
    
    override var bounds: CGRect {
        didSet {
            // Check if bounds has been changed and if the new value is different from old value
            guard bounds != .zero, oldValue != bounds else { return }
            self.roundCorners(corners: corners, radius: cornerRadius)
            setupCorners()
        }
    }

    /// The value of corner radius
    @IBInspectable var cornerRadius: CGFloat = 20 {
        didSet {
            self.roundCorners(corners: corners, radius: cornerRadius)
        }
    }
    
    /// The specific corners to round
    @IBInspectable var corners: UIRectCorner = .allCorners {
        didSet {
            self.roundCorners(corners: corners, radius: cornerRadius)
        }
    }
    
    /// Round the specific corners of view
    private func setupCorners() {
        // Remove the mask if already exist
        cornerMask?.removeFromSuperlayer()
        // Create the path by rounding corners
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        // Create a mask
        cornerMask = CAShapeLayer()
        // Assign the rounding path to the corner mask path
        cornerMask?.path = path.cgPath
        // Assing the corner mask to layer mask
        layer.mask = cornerMask
    }

}
