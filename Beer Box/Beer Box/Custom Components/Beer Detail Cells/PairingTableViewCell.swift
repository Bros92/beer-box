//
//  PairingTableViewCell.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 07/05/22.
//

import UIKit

class PairingTableViewCell: UITableViewCell, Reusable {
    
    static var reuseIdentifier: String {
        "pairingTableViewCell"
    }
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoRegular(size: 16)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoRegular(size: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(descriptionLabel)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            numberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.numberLabel.trailingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: self.descriptionLabel.trailingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: numberLabel.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 5)
        ])
    }

    func configure(for description: String, at row: Int) {
        numberLabel.text = "\(row)."
        descriptionLabel.text = description
    }
}
