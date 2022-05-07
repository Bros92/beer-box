//
//  HopTableViewCell.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 07/05/22.
//

import UIKit

class HopTableViewCell: UITableViewCell, Reusable {
    
    static var reuseIdentifier: String {
        "hopTableViewCell"
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoBold(size: 16)
        label.text = "NAME".localized
        return label
    }()
    
    private lazy var nameLabelValue: UILabel = {
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
    
    private lazy var amountLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoRegular(size: 16)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var addLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoBold(size: 16)
        label.text = "ADD".localized
        return label
    }()
    
    private lazy var addLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoRegular(size: 16)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoBold(size: 16)
        label.text = "ATTRIBUTE".localized
        return label
    }()
    
    private lazy var attributeLabelValue: UILabel = {
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
    
    private func setupUI() {
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(nameLabelValue)
        self.contentView.addSubview(amountLabel)
        self.contentView.addSubview(amountLabelValue)
        self.contentView.addSubview(addLabel)
        self.contentView.addSubview(addLabelValue)
        self.contentView.addSubview(attributeLabel)
        self.contentView.addSubview(attributeLabelValue)
        self.contentView.addSubview(separatorView)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            nameLabelValue.topAnchor.constraint(equalTo: self.nameLabel.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.nameLabelValue.trailingAnchor, constant: 20),
            nameLabelValue.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 10),
            amountLabel.topAnchor.constraint(equalTo: nameLabelValue.bottomAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            amountLabelValue.topAnchor.constraint(equalTo: amountLabel.topAnchor),
            amountLabelValue.leadingAnchor.constraint(equalTo: self.amountLabel.trailingAnchor, constant: 10),
            amountLabelValue.trailingAnchor.constraint(equalTo: nameLabelValue.trailingAnchor),
            addLabel.topAnchor.constraint(equalTo: self.amountLabelValue.bottomAnchor, constant: 10),
            addLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            addLabelValue.topAnchor.constraint(equalTo: self.addLabel.topAnchor),
            addLabelValue.leadingAnchor.constraint(equalTo: addLabel.trailingAnchor, constant: 10),
            addLabelValue.trailingAnchor.constraint(equalTo: self.nameLabelValue.trailingAnchor),
            attributeLabel.topAnchor.constraint(equalTo: self.addLabelValue.bottomAnchor, constant: 10),
            attributeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            attributeLabelValue.topAnchor.constraint(equalTo: attributeLabel.topAnchor),
            attributeLabelValue.leadingAnchor.constraint(equalTo: attributeLabel.trailingAnchor, constant: 10),
            attributeLabelValue.trailingAnchor.constraint(equalTo: self.nameLabelValue.trailingAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: attributeLabelValue.bottomAnchor, constant: 10),
            separatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.nameLabelValue.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    /// Configure the UI for data hop
    /// - Parameter malt: the data of hop
    func configure(for hop: Hop, isLast: Bool) {
        self.nameLabelValue.text = hop.name
        self.amountLabelValue.text = "\(hop.amount.value) \(hop.amount.unit)"
        self.addLabelValue.text = hop.add
        self.attributeLabelValue.text = hop.attribute
        self.separatorView.isHidden = isLast
    }
}
