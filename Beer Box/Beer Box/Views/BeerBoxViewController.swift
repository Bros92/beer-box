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
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: BeerTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.separatorColor = UIColor.mode(dark: .separatorLine, light: .lightGray)
        tableView.separatorInset = .zero
        return tableView
    }()
    
    /// The data source of table view
    private var beerDataSource: UITableViewDiffableDataSource<MainSection, Beer>?
    /// The presenter of view controller
    private var presenter = BeerBoxPresener()
    private var tapGesture: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(searchBar)
        self.view.addSubview(bannerView)
        self.view.addSubview(beerTableView)

        self.view.backgroundColor = UIColor.mode(dark: .darkGray, light: .mediumWhite)
        self.presenter.viewPresenter = self
        beerDataSource = UITableViewDiffableDataSource<MainSection, Beer>(tableView: self.beerTableView, cellProvider: { [weak self] tableView, indexPath, beer in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.reuseIdentifier, for: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(for: beer)
            return cell
        })
        
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
            beerTableView.topAnchor.constraint(equalTo: self.bannerView.bottomAnchor),
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
    private func tapOut() {
        searchBar.endEditing(true)
    }
    
    @objc
    private func keyboardWillShow() {
        presenter.isKeyboardShown = true
    }
    
    @objc
    private func keyboardWillHide() {
        presenter.isKeyboardShown = false
    }
}

extension BeerBoxViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Start to filter beer only if the user inserted 3 or more characters, otherwise reset filter
        if let searchBarText = searchBar.text,
           let textRange = Range(range, in: searchBarText) {
            let updatedText = searchBarText.replacingCharacters(in: textRange,
                                                       with: text)
            if text.isValid {
                presenter.updateFilter(for: updatedText.count >= 3 ? updatedText : nil)
            }
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Dismiss the keyboard when the search button has been tapped
        self.tapOut()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
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
    func showError(title: String, message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized, style: .cancel)
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
    }
    
    func showActivityLoader() {
        self.showLoader()
    }
    
    func hideActivityLoader() {
        self.hideLoader()
    }
    
    func updateTableViewSnapshot() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<MainSection, Beer>()
            snapshot.appendSections([.main])
            snapshot.appendItems(strongSelf.presenter.filterBeers(), toSection: .main)
            self?.beerDataSource?.applySnapshotUsingReloadData(snapshot)
        }
    }
}

extension BeerBoxViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.beersList.count - 1, !self.presenter.downloadCompleted {
            self.presenter.getBeers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = beerDataSource?.itemIdentifier(for: indexPath) else { return }
        let beerDetailViewController = BeerDetailViewController()
        beerDetailViewController.presenter = BeerDetailPresenter(beer: item)
        DispatchQueue.main.async { [weak self] in
            self?.present(beerDetailViewController, animated: true)
        }
    }
}

extension BeerBoxViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == tapGesture, presenter.isKeyboardShown {
            return true
        } else if gestureRecognizer != tapGesture, !presenter.isKeyboardShown {
            return  true
        }
        return false
    }
}
