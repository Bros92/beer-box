//
//  BeerDetailViewController.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 06/05/22.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    var beer: Beer?
    
    private lazy var beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.mode(dark: .yellowOcher, light: .electricBlue).cgColor
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.dismiss(animated: true)
        }), for: .touchUpInside)
        button.tintColor = UIColor.mode(dark: .yellowOcher, light: .electricBlue)
        button.setImage(UIImage(systemName: "cross"), for: .normal)
        return button
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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.mode(dark: .darkGray, light: .mediumWhite)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        beerImageView.layer.cornerRadius = beerImageView.bounds.height / 2
    }
}
