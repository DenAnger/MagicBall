//
//  SubViewController.swift
//  MagicBall
//
//  Created by Denis Abramov on 04.07.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import UIKit
import StoreKit

class SubViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // MARK: Variables
    let subManager = SubManager.shared
    let notificationCenter = NotificationCenter.default
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        tableView.tableFooterView = UIView()
        
        notifications()
    }
    
    // MARK: Actions
    @objc private func restorePurchases() {
        subManager.restoreCompletedTransactions()
    }
    
    @objc private func reload() {
        self.tableView.reloadData()
    }
    
    @objc private func completeOneMonth() {
        print("got 1 Month")
    }
    
    @objc private func completeSixMonth() {
        print("got 6 month")
    }
    
    @objc private func completeOneYear() {
        print("got 1 Year")
    }
    
    // MARK: Methods
    func notifications() {
        notificationCenter.addObserver(
            self,
            selector: #selector(reload),
            name: NSNotification.Name(SubManager.subNotificationIdentifier),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeOneMonth),
            name: NSNotification.Name(SubProducts.autoRenewableOneMonth.rawValue),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeSixMonth),
            name: NSNotification.Name(SubProducts.autoRenewableSixMonth.rawValue),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeOneYear),
            name: NSNotification.Name(SubProducts.autoRenewableOneYear.rawValue),
            object: nil
        )
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Restore sub",
            style: .plain,
            target: self,
            action: #selector(restorePurchases)
        )
    }
    
    private func notificationProductList() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reload),
            name: NSNotification.Name(rawValue: SubManager.subNotificationIdentifier),
            object: nil
        )
    }
    
    private func priceFor(product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        
        return numberFormatter.string(from: product.price)!
    }
    
    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Data Source
extension SubViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return subManager.products.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellIdentifier.subCell,
            for: indexPath
        )
        let product = subManager.products[indexPath.row]
        cell.textLabel?.text = product.localizedTitle + " - " +
        self.priceFor(product: product)
        return cell
    }
}

// MARK: - Delegate
extension SubViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let identifier = subManager.products[indexPath.row].productIdentifier
        subManager.purchase(productWith: identifier)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
