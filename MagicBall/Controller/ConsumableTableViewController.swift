//
//  ConsumableTableViewController.swift
//  MagicBall
//
//  Created by Denis Abramov on 04.07.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import UIKit
import StoreKit

class ConsumableTableViewController: UITableViewController {

    // MARK: Variables
    let consumableManager = ConsumableManager.shared
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
        consumableManager.restoreCompletedTransactions()
    }
    
    @objc private func reload() {
        self.tableView.reloadData()
    }
    
    @objc private func completeACupOfTea() {
        print("got a cup of tea")
    }
    
    @objc private func completeDinner() {
        print("got dinner")
    }
    
    @objc private func completeRestaurant() {
        print("got restaurant")
    }
    
    @objc private func completeBall() {
        print("got ball")
    }
    
    @objc private func completeBackground() {
        print("got background")
    }
    
    @objc private func completeFunction() {
        print("got function")
    }
    
    @objc private func completeSecret() {
        print("got secret")
    }
    
    // MARK: Methods
    func notifications() {
        notificationCenter.addObserver(
            self,
            selector: #selector(reload),
            name: NSNotification.Name(ConsumableManager.consumableNotificationIdentifier),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeACupOfTea),
            name: NSNotification.Name(ConsumableProducts.buyACupOfTea.rawValue),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeDinner),
            name: NSNotification.Name(ConsumableProducts.buyDinner.rawValue),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeRestaurant),
            name: NSNotification.Name(ConsumableProducts.buyRestaurant.rawValue),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeBall),
            name: NSNotification.Name(ConsumableProducts.buyNewBall.rawValue),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeBackground),
            name: NSNotification.Name(ConsumableProducts.buyNewBackground.rawValue),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeFunction),
            name: NSNotification.Name(ConsumableProducts.buyNewFunction.rawValue),
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(completeSecret),
            name: NSNotification.Name(ConsumableProducts.buyNewSecret.rawValue),
            object: nil
        )
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Restore donate",
            style: .plain,
            target: self,
            action: #selector(restorePurchases)
        )
    }
    
    private func notificationProductList() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reload),
            name: NSNotification.Name(rawValue: ConsumableManager.consumableNotificationIdentifier),
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
extension ConsumableTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return consumableManager.products.count
    }
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellIdentifier.consumableCell,
            for: indexPath
        )
        let product = consumableManager.products[indexPath.row]
        cell.textLabel?.text = product.localizedTitle + " - " +
        self.priceFor(product: product)
        return cell
    }
}

// MARK: - Delegate
extension ConsumableTableViewController {
    override func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let identifier = consumableManager.products[indexPath.row].productIdentifier
        consumableManager.purchase(productWith: identifier)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
