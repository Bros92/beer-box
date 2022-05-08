//
//  BeerTableViewCell.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import UIKit

protocol BeerTableViewCellDelegate: AnyObject {
    func moreInfoTapped(data: PopupData)
}

class BeerTableViewCell: UITableViewCell, Reusable {
    
    /// The reuse identifier of cell
    static var reuseIdentifier: String {
        "beerTableViewCell"
    }
    
    /// The delegate of cell
    weak var delegate: BeerTableViewCellDelegate?
    
    /// The title label of beer
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .mediumWhite, light: .semiDarkGray)
        label.font = UIFont.arabotoRegular(size: 14)
        return label
    }()
    
    /// The label of family of beer
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.font = UIFont.arabotoRegular(size: 12)
        return label
    }()
    
    /// The label of partial description of beer
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        label.numberOfLines = 2
        label.font = UIFont.arabotoRegular(size: 12)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// The button to show the untrunched description
    private lazy var moreInfoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("MORE_INFO".localized.uppercased(), for: .normal)
        button.setTitleColor(UIColor.mode(dark: .yellowOcher, light: .electricBlue), for: .normal)
        button.titleLabel?.font = UIFont.arabotoRegular(size: 14)
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            let data = PopupData(title: strongSelf.titleLabel.text, subtitle: strongSelf.subTitleLabel.text, image: strongSelf.beerImageView.image, infoDescription: strongSelf.descriptionLabel.text)
            self?.delegate?.moreInfoTapped(data: data)
        }), for: .touchUpInside)
        return button
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
        
        self.contentView.addSubview(beerImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subTitleLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(moreInfoButton)
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            self.beerImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
            beerImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            beerImageView.widthAnchor.constraint(equalTo: beerImageView.heightAnchor, multiplier: 0.5),
            beerImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.beerImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.beerImageView.trailingAnchor, constant: 10),
            self.contentView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10),
            subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            moreInfoButton.bottomAnchor.constraint(equalTo: self.beerImageView.bottomAnchor),
            moreInfoButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            moreInfoButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 10)
        ])
    }
    
    func configure(for beer: Beer) {
        self.descriptionLabel.text = beer.infoDescription
        self.titleLabel.text = beer.name
        self.subTitleLabel.text = beer.tagline
        guard let imageUrl = beer.imageUrl, let url = URL(string: imageUrl) else {
            self.beerImageView.image = UIImage(named: "beer")
            return
        }
        self.beerImageView.getData(from: url)
    }
}
