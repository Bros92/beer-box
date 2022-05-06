//
//  BannerView.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import UIKit

/// The custom view for banner
@IBDesignable
class BannerView: UIView {
    
    /// The image view of banner view
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = bannerImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// The label of banner title
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.arabotoBold(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    /// The label of banner description
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.arabotoRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    /// The container view to
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// The image of banner view
    @IBInspectable
    var bannerImage: UIImage? = UIImage(named: "box-icon") {
        didSet {
            self.bannerImageView.image = bannerImage
        }
    }
    
    /// The text of title label
    @IBInspectable
    var titleText: String = "" {
        didSet {
            self.titleLabel.text = titleText
        }
    }
    
    /// The text color of tilte label
    @IBInspectable
    var titleTextColor: UIColor = .black {
        didSet {
            self.titleLabel.textColor = titleTextColor
        }
    }
    
    /// The text of description label
    @IBInspectable
    var descriptionText: String = "" {
        didSet {
            self.descriptionLabel.text = descriptionText
        }
    }
    
    /// The text color of description label
    @IBInspectable
    var descriptionTextColor: UIColor = .black {
        didSet {
            self.descriptionLabel.textColor = descriptionTextColor
        }
    }
    
    @IBInspectable
    /// The value of corner radius of view
    var borderRadius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = borderRadius
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
    
    /// Setup the UI of view
    private func setupUI() {
        self.addSubview(containerView)
        self.addSubview(bannerImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        self.layer.cornerRadius = borderRadius
        
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: self.bannerImageView.trailingAnchor, constant: 10),
            bannerImageView.leadingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: 5),
            self.bannerImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.bannerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.containerView.bottomAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor),
            self.containerView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
    }
}
