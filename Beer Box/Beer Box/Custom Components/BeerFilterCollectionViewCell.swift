//
//  BeerFilterCollectionViewCell.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 08/05/22.
//

import UIKit

class BeerFilterCollectionViewCell: UICollectionViewCell, Reusable {
    
    static var reuseIdentifier: String {
        "beerFilterCollectionViewCell"
    }
    
    private lazy var beerTypeLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .mediumWhite, light: .semiDarkGray)
        label.font = UIFont.arabotoRegular(size: 12)
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.backgroundColor = UIColor.mode(dark: .mediumGray, light: .opaqueWhite)
        label.leftInset = 30
        label.rightInset = 30
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                beerTypeLabel.backgroundColor = UIColor.mode(dark: .yellowOcher, light: .electricBlue)
                beerTypeLabel.textColor = UIColor.mode(dark: .semiDarkGray, light: .mediumWhite)
            } else {
                beerTypeLabel.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
                beerTypeLabel.backgroundColor = UIColor.mode(dark: .mediumGray, light: .opaqueWhite)
            }
        }
    }
    
    override var bounds: CGRect {
        didSet {
            self.beerTypeLabel.roundCorners(corners: .allCorners, radius: (self.bounds.height - 10) / 2)
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
    
    private func setupUI() {
        
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(beerTypeLabel)
        NSLayoutConstraint.activate([
            beerTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: beerTypeLabel.trailingAnchor),
            beerTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            beerTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    func configureUI(for type: BeerType) {
        self.beerTypeLabel.text = type.localizedType
    }
}
