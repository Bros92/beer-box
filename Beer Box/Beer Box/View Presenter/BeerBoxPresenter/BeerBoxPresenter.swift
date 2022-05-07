//
//  BeerBoxPresenter.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import Foundation

class BeerBoxPresener {
    
    weak var viewPresenter: BeerBoxViewPresenter?
    
    private(set) var beersList = [Beer]()
    /// True if there are no more items to download
    private(set) var downloadCompleted = false
    /// The number of pages downloaded
    private var page = 1
    /// The sale value
    let sale: Double = 60
    /// A boolean to indicate if keyboard has been shown
    var isKeyboardShown = false
    /// The filtered beer name
    private(set) var filteredName: String? {
        didSet {
            guard oldValue != filteredName else { return }
            self.viewPresenter?.updateTableViewSnapshot()
        }
    }
    
    /// API call to get new beers
    func getBeers(for name: String? = nil) {
        self.viewPresenter?.showActivityLoader()
        let request = BeerRequest(page: page, name: name)
        let endpoint = APIBeerEndpoint.getBeerList(request)
        API.dev.makeRequest([Beer].self, at: endpoint) { [weak self] result in
            self?.viewPresenter?.hideActivityLoader()
            switch result {
            case .success(let beersList):
                guard !beersList.isEmpty else {
                    self?.downloadCompleted = true
                    return
                }
                self?.page += 1
                self?.beersList.append(contentsOf: beersList)
                self?.viewPresenter?.updateTableViewSnapshot()
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self?.viewPresenter?.showError(title: "GENERIC_ERROR_TITLE".localized, message: "GENERIC_ERROR_DESCRIPTION".localized)
            }
        }
    }
    
    /// Filter the beers list for name got in search bar.
    /// - Returns: A filtered beers list
    func filterBeers() -> [Beer] {
        guard let filteredName = filteredName else {
            return beersList
        }
        return beersList.filter({ $0.name.contains(filteredName) })
    }
    
    /// Remove filter and return the complete beers list.
    func resetFilter() {
        self.page = 1
        self.filteredName = nil
    }
    
    /// Update the filtered beer name
    func updateFilter(for name: String?) {
        self.filteredName = name
    }
}
