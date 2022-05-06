//
//  LoaderView.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 06/05/22.
//

import UIKit

class LoaderView: UIView {
    
    /// The activity indicator view
    var activityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    /// Setup the ui of the view
    private func setupUI() {
        
        self.backgroundColor = .white.withAlphaComponent(0.5)
        activityIndicatorView.style = .large
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            self.activityIndicatorView.heightAnchor.constraint(equalToConstant: 40),
            self.activityIndicatorView.widthAnchor.constraint(equalTo: self.activityIndicatorView.heightAnchor),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    /// Start the animation of activity indicator
    func startAnimation() {
        activityIndicatorView.startAnimating()
    }
    
    /// Stop the animation of activity indicator
    func stopAnimation() {
        activityIndicatorView.stopAnimating()
    }
}
