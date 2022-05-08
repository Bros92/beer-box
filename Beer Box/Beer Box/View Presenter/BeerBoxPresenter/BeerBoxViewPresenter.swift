//
//  BeerBoxViewPresenter.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import Foundation

protocol BeerBoxViewPresenter: ErrorViewPresenter, LoaderViewPresenter {
    func updateTableViewSnapshot()
    func updateCollectionViewSnapshot()
}
