//
//  BeerDetailHeader.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 07/05/22.
//

import UIKit

@IBDesignable
class BeerDetailHeader: UITableViewHeaderFooterView, Reusable {

    static var reuseIdentifier: String {
        "beerDetailHeader"
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.mode(dark: .mediumWhite, light: .semiDarkGray)
        label.textAlignment = .center
        label.font = UIFont.arabotoBold(size: 21)
        return label
    }()
    
    @IBInspectable
    var textColor: UIColor = UIColor.mode(dark: .mediumWhite, light: .semiDarkGray) {
        didSet {
            self.titleLabel.textColor = textColor
        }
    }
    
    @IBInspectable
    var text: String = "" {
        didSet {
            self.titleLabel.text = text
        }
    }
    
    @IBInspectable
    var fontSize: CGFloat = 21 {
        didSet {
            self.titleLabel.font = .arabotoBold(size: fontSize)
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        
        self.backgroundView = UIView()
        self.contentView.addSubview(titleLabel)
        self.contentView.backgroundColor = UIColor.mode(dark: .darkGray, light: .mediumWhite)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        ])
    }
}
