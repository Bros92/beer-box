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

enum BeerSection {
    case main
}
