//
//  Utilities.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}

protocol ErrorViewPresenter: AnyObject {
    /// Show the alert for the error message
    func showError(title: String, message: String)
}

protocol LoaderViewPresenter: AnyObject {
    /// Show actiivity loader
    func showActivityLoader()
    /// Hide activity loader
    func hideActivityLoader()
}

enum MainSection {
    case main
}
