//
//  PopupViewController.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 06/05/22.
//

import UIKit

/// The View Controller to manage the popup of app
class PopupViewController: UIViewController {
    
    /// The presenter of popup
    var presenter: PopupPresenter?
    
    /// The background blur effect
    private lazy var blurView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
    /// The bookmark of popup
    private lazy var bookmarkView: BookmarkView = {
        let view = BookmarkView()
        view.fillColor = UIColor.mode(dark: .yellowOcher, light: .electricBlue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// The content view of popup
    private lazy var contentView: RoundedView = {
        let view = RoundedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.corners = [.topLeft, .topRight]
        view.backgroundColor = UIColor.mode(dark: .darkGray, light: .mediumWhite)
        return view
    }()
    
    /// The title label of beer
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.mode(dark: .mediumWhite, light: .semiDarkGray)
        label.font = UIFont.arabotoRegular(size: 20)
        return label
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
    
    /// The image view of beer
    private lazy var beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    /// The bottom layout constraint
    private var bottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add all views
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
            beerImageView.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 20),
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
        // Add swipe down gesture to content view
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipeGesture.direction = .down
        contentView.addGestureRecognizer(swipeGesture)
        bottomConstraint = contentView.bottomAnchor.constraint(equalTo: self.blurView.bottomAnchor)
        bottomConstraint?.isActive = true
        bottomConstraint?.constant = 500

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.contentView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        // Set data
        titleLabel.text = presenter?.data.title
        subTitleLabel.text = presenter?.data.subtitle
        descriptionLabel.text = presenter?.data.infoDescription
        beerImageView.image = presenter?.data.image
        
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.4) {
                self?.bottomConstraint?.constant = 0
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    /// Hide content view and dismiss the view
    @objc
    func dismissView() {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.4) {
                self?.bottomConstraint?.constant = 500
                self?.view.layoutIfNeeded()
            } completion: { executed in
                // Dismiss view controller only if animation has been executed
                if executed {
                    self?.dismiss(animated: true)
                }
            }
        }
    }
}
