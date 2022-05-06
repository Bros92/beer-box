//
//  PopupViewController.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 06/05/22.
//

import UIKit

/// The View Controller to manage the popup of app
class PopupViewController: UIViewController {
    
    lazy var blurView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = AnimatedBlurEffect(effect: blurEffect, intensity: 0.2)
        // 3. create semi-transparent black view
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
        dimmedView.frame = self.view.bounds
        
        // 4. add both as subviews
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    /// The bookmark of popup
    private lazy var bookmarkView: BookmarkView = {
        let view = BookmarkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// The content view of popup
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    /// The title label of beer
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .mediumWhite
        label.font = UIFont.arabotoRegular(size: 20)
        label.text = "Buzz"
        return label
    }()
    
    /// The label of family of beer
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .veryLightGray
        label.font = UIFont.arabotoRegular(size: 16)
        label.text = "A Real Bitter Experience."
        return label
    }()
    
    /// The label of  description of beer
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .veryLightGray
        label.numberOfLines = 0
        label.font = UIFont.arabotoRegular(size: 16)
        label.text = "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once."
        return label
    }()
    
    /// The image view of beer
    private lazy var beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "box-icon")
        return imageView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(blurView)
        self.view.addSubview(contentView)
        self.contentView.addSubview(bookmarkView)
        self.contentView.addSubview(beerImageView)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(subTitleLabel)
        self.contentView.addSubview(titleLabel)
        view.sendSubviewToBack(blurView)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.blurView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.blurView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.blurView.trailingAnchor),
            contentView.topAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor),
            bookmarkView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.bookmarkView.trailingAnchor, constant: 20),
            bookmarkView.heightAnchor.constraint(equalToConstant: 30),
            bookmarkView.widthAnchor.constraint(equalTo: bookmarkView.heightAnchor, multiplier: 0.63),
            beerImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            beerImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25),
            beerImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            beerImageView.heightAnchor.constraint(equalTo: self.beerImageView.widthAnchor, multiplier: 2),
            titleLabel.topAnchor.constraint(equalTo: self.bookmarkView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.beerImageView.trailingAnchor, constant: 10),
            self.bookmarkView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10),
            subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: self.bookmarkView.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.subTitleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 10),
            self.contentView.bottomAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20)
        ])
        
        self.contentView.layer.cornerRadius = 20
    }
}
