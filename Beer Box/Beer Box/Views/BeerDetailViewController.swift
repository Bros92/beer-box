//
//  BeerDetailViewController.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 06/05/22.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    var presenter: BeerDetailPresenter?
    
    /// The title label of beer
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.mode(dark: .mediumWhite, light: .semiDarkGray)
        label.font = UIFont.arabotoBold(size: 30)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            // Disimiss the view controller
            self?.dismiss(animated: true)
        }), for: .touchUpInside)
        button.tintColor = UIColor.mode(dark: .yellowOcher, light: .electricBlue)
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    private lazy var beerTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.register(GeneralInfoTableViewCell.self, forCellReuseIdentifier: GeneralInfoTableViewCell.reuseIdentifier)
        tableView.register(MaltTableViewCell.self, forCellReuseIdentifier: MaltTableViewCell.reuseIdentifier)
        tableView.register(HopTableViewCell.self, forCellReuseIdentifier: HopTableViewCell.reuseIdentifier)
        tableView.register(PairingTableViewCell.self, forCellReuseIdentifier: PairingTableViewCell.reuseIdentifier)
        tableView.register(BeerDetailHeader.self, forHeaderFooterViewReuseIdentifier: BeerDetailHeader.reuseIdentifier)
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    /// The data source of beer detail
    private var beerDataSource: UITableViewDiffableDataSource<BeerDetailSection, AnyHashable>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(beerTableView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(closeButton)
        
        self.view.backgroundColor = UIColor.mode(dark: .darkGray, light: .mediumWhite)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(greaterThanOrEqualTo: self.titleLabel.trailingAnchor, constant: 5),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: self.closeButton.trailingAnchor, constant: 10),
            beerTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            beerTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            beerTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            beerTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        beerDataSource = UITableViewDiffableDataSource<BeerDetailSection, AnyHashable>(tableView: beerTableView, cellProvider: { [weak self] tableView, indexPath, item in
            guard let strongSelf = self, let presenter = strongSelf.presenter else {
                return UITableViewCell()
            }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: GeneralInfoTableViewCell.reuseIdentifier, for: indexPath) as? GeneralInfoTableViewCell, let beer = item as? Beer {
                cell.configuire(for: beer)
                return cell
            } else if let cell = tableView.dequeueReusableCell(withIdentifier: MaltTableViewCell.reuseIdentifier, for: indexPath) as? MaltTableViewCell, let malt = item as? Malt {
                cell.configure(for: malt, isLast: presenter.beer.ingredients.malt.count - 1 == indexPath.row)
                return cell
            } else if let cell = tableView.dequeueReusableCell(withIdentifier: HopTableViewCell.reuseIdentifier, for: indexPath) as? HopTableViewCell, let hop = item as? Hop {
                cell.configure(for: hop, isLast: presenter.beer.ingredients.hops.count - 1 == indexPath.row)
                return cell
            } else if let cell = tableView.dequeueReusableCell(withIdentifier: PairingTableViewCell.reuseIdentifier, for: indexPath) as? PairingTableViewCell, let pairingDescription = item as? String {
                cell.configure(for: pairingDescription, at: indexPath.row + 1)
                return cell
            }
            
            return UITableViewCell()
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = presenter?.beer.name
        setupSnapshot()
    }
    
    private func setupSnapshot() {
        guard let presenter = presenter else { return }
        var snapshot = NSDiffableDataSourceSnapshot<BeerDetailSection, AnyHashable>()
        snapshot.appendSections(BeerDetailSection.allCases)
        snapshot.appendItems([presenter.beer], toSection: .generalInfo)
        snapshot.appendItems(presenter.beer.ingredients.malt, toSection: .malts)
        snapshot.appendItems(presenter.beer.ingredients.hops, toSection: .hops)
        snapshot.appendItems(presenter.beer.foodPairing, toSection: .pairing)
        beerDataSource?.applySnapshotUsingReloadData(snapshot)
    }
}

extension BeerDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BeerDetailHeader.reuseIdentifier) as? BeerDetailHeader,
            let beerDetailSection = BeerDetailSection(rawValue: section) else {
            return UIView()
        }
        header.text = beerDetailSection.description
        return header
    }
}
