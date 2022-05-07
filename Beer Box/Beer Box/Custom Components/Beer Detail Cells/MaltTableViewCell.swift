//
//  IngredientsTableViewCell.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 07/05/22.
//

import UIKit

class MaltTableViewCell: UITableViewCell, Reusable {
    
    static var reuseIdentifier: String {
        "maltTableViewCell"
    }

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoBold(size: 16)
        label.text = "NAME".localized
        return label
    }()
    
    private lazy var nameValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoRegular(size: 16)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoBold(size: 16)
        label.text = "AMOUNT".localized
        return label
    }()

    private lazy var amountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoRegular(size: 16)
        label.textAlignment = .right
        return label
    }()
    
    /// The custom separator view of cell
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.mode(dark: .separatorLine, light: .lightGray)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    /// Setup the UI of cell
    private func setupUI() {
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(nameValueLabel)
        self.contentView.addSubview(amountLabel)
        self.contentView.addSubview(amountValueLabel)
        self.contentView.addSubview(separatorView)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        // Remove selection syle
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            nameValueLabel.topAnchor.constraint(equalTo: self.nameLabel.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.nameValueLabel.trailingAnchor, constant: 20),
            nameValueLabel.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 10),
            amountLabel.topAnchor.constraint(equalTo: nameValueLabel.bottomAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            amountValueLabel.leadingAnchor.constraint(equalTo: self.amountLabel.trailingAnchor, constant: 10),
            amountValueLabel.trailingAnchor.constraint(equalTo: nameValueLabel.trailingAnchor),
            amountValueLabel.topAnchor.constraint(equalTo: self.amountLabel.topAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: self.amountValueLabel.bottomAnchor, constant: 10),
            separatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: nameValueLabel.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    /// Configure the UI for data malt
    /// - Parameter malt: the data of malt
    /// - Parameter isLast: A boolean to indicate if the current cell is the last
    func configure(for malt: Malt, isLast: Bool) {
        self.nameValueLabel.text = malt.name
        self.amountValueLabel.text = "\(malt.amount.value) \(malt.amount.unit)"
        separatorView.isHidden = isLast
    }
}
