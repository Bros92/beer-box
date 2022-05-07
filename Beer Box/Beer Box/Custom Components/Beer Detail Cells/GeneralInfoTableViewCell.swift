//
//  GeneralInfoTableViewCell.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 07/05/22.
//

import UIKit

class GeneralInfoTableViewCell: UITableViewCell, Reusable {
    
    /// The reuse identifier of cell
    static var reuseIdentifier: String {
        "generalInfoTableViewCell"
    }
    
    /// The rounded image view of beer
    private lazy var beerImageView: CircularImageView = {
        let imageView = CircularImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.borderWidth = 2
        imageView.borderColor = UIColor.mode(dark: .yellowOcher, light: .electricBlue)
        imageView.backgroundColor = UIColor.mode(dark: .clear, light: .yellowOcher)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// The label of family of beer
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoRegular(size: 16)
        return label
    }()
    
    /// The label of  description of beer
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.numberOfLines = 0
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
        // Add subviews
        self.contentView.addSubview(beerImageView)
        self.contentView.addSubview(subTitleLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        // Remove selection syle
        self.selectionStyle = .none
        
        // Active constraint
        NSLayoutConstraint.activate([
            self.beerImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.beerImageView.heightAnchor.constraint(equalToConstant: 100),
            self.beerImageView.widthAnchor.constraint(equalTo: self.beerImageView.heightAnchor),
            self.beerImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.beerImageView.bottomAnchor, constant: 30),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.subTitleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 20),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.subTitleLabel.leadingAnchor),
            self.descriptionLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 10)
        ])
    }
    
    /// Configure the UI of cell with beer info
    /// - Parameter beer: the data of beer
    func configuire(for beer: Beer) {
        self.subTitleLabel.text = beer.tagline
        self.descriptionLabel.text = beer.infoDescription
        guard let url = URL(string: beer.imageUrl) else { return }
        beerImageView.getData(from: url)
    }
}
