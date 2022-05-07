//
//  BeerDetailPresenter.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 07/05/22.
//

import Foundation

enum BeerDetailSection: Int, CaseIterable {
    case generalInfo = 0
    case malts
    case hops
    case pairing
    
    var description: String {
        switch self {
        case .generalInfo:
            return "DESCRIPTION".localized
        case .malts:
            return "MALTS".localized
        case .hops:
            return "HOPS".localized
        case .pairing:
            return  "FOOD_PAIRING_SUGGESTED".localized
        }
    }
}

class BeerDetailPresenter {
    
    let beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
    }
}
