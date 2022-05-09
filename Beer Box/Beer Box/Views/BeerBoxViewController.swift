//
//  BeerBoxViewController.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import UIKit

class BeerBoxViewController: UIViewController {
    
    private lazy var bannerView: BannerView = {
        let view = BannerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleText = "BANNER_TITLE".localized
        view.titleTextColor = UIColor.mode(dark: .semiDarkGray, light: .mediumWhite)
        view.descriptionText = "BANNER_DESCRIPTION".localized(with: [presenter.sale.toCurrency()])
        view.descriptionTextColor = UIColor.mode(dark: .semiDarkGray, light: .mediumWhite)
        view.bannerImage = UIImage(named: "box-icon")
        view.backgroundColor = UIColor.mode(dark: .yellowOcher, light: .electricBlue)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSMutableAttributedString()
            .arabotoRegular("\("BEER".localized) ", fontSize: 30, color: UIColor.mode(dark: .mediumWhite, light: .semiDarkGray))
            .arabotoBold("BOX".localized, fontSize: 30, color: UIColor.mode(dark: .mediumWhite, light: .semiDarkGray))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = UIColor.mode(dark: .mediumGray, light: .opaqueWhite)
        searchBar.searchTextField.font = UIFont.arabotoRegular(size: 11)
        searchBar.searchTextField.textColor = UIColor.mode(dark: .veryLightGray, light: .mediumGray)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "SEARCH".localized, attributes: [
            .foregroundColor: UIColor.mode(dark: .veryLightGray, light: .mediumGray),
            .font: UIFont.arabotoRegular(size: 11) as Any
        ])
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        return searchBar
    }()
    
    private lazy var beerTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isPrefetchingEnabled = false
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.separatorColor = UIColor.mode(dark: .separatorLine, light: .lightGray)
        tableView.separatorInset = .zero
        return tableView
    }()
    
    private lazy var filterCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPrefetchingEnabled = false
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.estimated(200),
            heightDimension: NSCollectionLayoutDimension.fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        var configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        collectionView.collectionViewLayout = layout
        collectionView.register(BeerFilterCollectionViewCell.self, forCellWithReuseIdentifier: BeerFilterCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    /// The data source of table view
    private var beerDataSource: UITableViewDiffableDataSource<MainSection, Beer>?
    /// The data source of collection view
    private var filterDataSource: UICollectionViewDiffableDataSource<MainSection, BeerType>?
    /// The presenter of view controller
    private var presenter = BeerBoxPresener()
    /// The tap out gesture recognize
    private var tapGesture: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add views
        self.view.addSubview(titleLabel)
        self.view.addSubview(searchBar)
        self.view.addSubview(bannerView)
        self.view.addSubview(filterCollectionView)
        self.view.addSubview(beerTableView)

        self.view.backgroundColor = UIColor.mode(dark: .darkGray, light: .mediumWhite)
        self.presenter.viewPresenter = self
        // Setup data source
        beerDataSource = UITableViewDiffableDataSource<MainSection, Beer>(tableView: self.beerTableView, cellProvider: { [weak self] tableView, indexPath, beer in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.reuseIdentifier, for: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(for: beer)
            return cell
        })
        
        filterDataSource = UICollectionViewDiffableDataSource<MainSection, BeerType>(collectionView: filterCollectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerFilterCollectionViewCell.reuseIdentifier, for: indexPath) as? BeerFilterCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureUI(for: item)
            return cell
        })
        
        // Add Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 11),
            searchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            bannerView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 20),
            bannerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            bannerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 70),
            filterCollectionView.topAnchor.constraint(equalTo: self.bannerView.bottomAnchor, constant: 20),
            filterCollectionView.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 50),
            beerTableView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor),
            beerTableView.leadingAnchor.constraint(equalTo: self.bannerView.leadingAnchor),
            beerTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            beerTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOut))
        tapGesture?.delegate = self
        guard let tapGesture = tapGesture else { return }
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateTableViewSnapshot()
        self.updateCollectionViewSnapshot()
        self.presenter.getBeers()
        
        // Add keyboard observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove keyboard observer
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    /// Dismiss the keyboard
    private func tapOut() {
        searchBar.endEditing(true)
    }
    
    @objc
    /// Show keyboard from observer
    private func keyboardWillShow() {
        presenter.isKeyboardShown = true
    }
    
    @objc
    /// Hide keyboard from observer
    private func keyboardWillHide() {
        presenter.isKeyboardShown = false
    }
}

extension BeerBoxViewController: UISearchBarDelegate, UITextFieldDelegate {
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Dismiss the keyboard when the search button has been tapped
        self.tapOut()
        guard let text = searchBar.text else { return }
        self.updateCollectionViewSnapshot()
        self.presenter.updateFilter(for: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Refresh beer list only text is empty and filter is not selected
        if searchText.isEmpty, presenter.filteredName != nil {
            self.updateCollectionViewSnapshot()
            self.presenter.resetFilter()
        }
    }
}

extension BeerBoxViewController: BeerTableViewCellDelegate {
    func moreInfoTapped(data: PopupData) {
        let popupController = PopupViewController()
        popupController.presenter = PopupPresenter(data: data)
        popupController.modalPresentationStyle = .overFullScreen
        popupController.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async { [weak self] in
            self?.present(popupController, animated: true)
        }
    }
}

extension BeerBoxViewController: BeerBoxViewPresenter {
    
    /// Show a system alert in case of api error
    func showError(title: String, message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized, style: .cancel)
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
    }
    
    /// Show the loader
    func showActivityLoader() {
        self.showLoader()
    }
    
    /// Hide the loader
    func hideActivityLoader() {
        self.hideLoader()
    }
    
    /// Update the snapshot of table view data source
    func updateTableViewSnapshot() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<MainSection, Beer>()
            snapshot.appendSections([.main])
            snapshot.appendItems(strongSelf.presenter.filterBeers(), toSection: .main)
            strongSelf.beerDataSource?.applySnapshotUsingReloadData(snapshot)
        }
    }
    
    /// Update the snapshot of collection view data source
    func updateCollectionViewSnapshot() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<MainSection, BeerType>()
            snapshot.appendSections([.main])
            snapshot.appendItems(strongSelf.presenter.filterBeerList, toSection: .main)
            strongSelf.filterDataSource?.applySnapshotUsingReloadData(snapshot)
        }
    }
}

extension BeerBoxViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Setup pagination
        if indexPath.row == presenter.beersList.count - 1, !self.presenter.downloadCompleted {
            self.presenter.getBeers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show beer details
        guard let item = beerDataSource?.itemIdentifier(for: indexPath) else { return }
        let beerDetailViewController = BeerDetailViewController()
        beerDetailViewController.presenter = BeerDetailPresenter(beer: item)
        DispatchQueue.main.async { [weak self] in
            self?.present(beerDetailViewController, animated: true)
        }
    }
}

extension BeerBoxViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath), let item = filterDataSource?.itemIdentifier(for: indexPath) else { return false }
        if cell.isSelected {
            collectionView.deselectItem(at: indexPath, animated: true)
            presenter.resetFilter()
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            presenter.updateFilter(for: item.localizedType)
            return true
        }
        return false
    }
}

extension BeerBoxViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Check if the gesture recognizer is the tap gesture
        if gestureRecognizer == tapGesture, presenter.isKeyboardShown {
            return true
        // Check if the gesture recognizer is the cell tapr
        } else if gestureRecognizer != tapGesture, !presenter.isKeyboardShown {
            return  true
        }
        return false
    }
}
