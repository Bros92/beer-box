//
//  CircularImageView.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 07/05/22.
//

import UIKit

@IBDesignable
class CircularImageView: UIImageView {
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .yellowOcher {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        setupUI()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        
        setupUI()
    }
    
    private func setupUI() {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
    
    override var bounds: CGRect {
        didSet {
            self.layer.cornerRadius = self.bounds.height / 2
        }
    }
}
