//
//  ConsumableManager.swift
//  MagicBall
//
//  Created by Denis Abramov on 04.07.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import Foundation
import StoreKit

class ConsumableManager: NSObject {
    
    let paymentQueue = SKPaymentQueue.default()
    var products: [SKProduct] = []
    
    static let shared = ConsumableManager()
    static let consumableNotificationIdentifier = "ConsumableManagerIdentifier"
    
    private override init() { }
    
    public func setupPurchases(callback: @escaping(Bool) -> ()) {
  
        if SKPaymentQueue.canMakePayments() {
            paymentQueue.add(self)
            callback(true)
            return
        }
        callback(false)
    }
    
    public func getProducts() {
        let identifires: Set = [
            ConsumableProducts.buyACupOfTea.rawValue,
            ConsumableProducts.buyDinner.rawValue,
            ConsumableProducts.buyRestaurant.rawValue,
            ConsumableProducts.buyNewBall.rawValue,
            ConsumableProducts.buyNewBackground.rawValue,
            ConsumableProducts.buyNewFunction.rawValue,
            ConsumableProducts.buyNewSecret.rawValue
        ]
        
        let productRequest = SKProductsRequest(productIdentifiers: identifires)
        productRequest.delegate = self
        productRequest.start()
    }
    
    public func purchase(productWith identifier: String) {
        
        guard let product = products.filter(
                { $0.productIdentifier == identifier }
        ).first else { return }
        
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
    }
    
    public func restoreCompletedTransactions() {
        paymentQueue.restoreCompletedTransactions()
    }
}

extension ConsumableManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue,
                      updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
            case .deferred:
                break
            case .purchasing:
                break
            case .failed:
                failed(transaction: transaction)
            case .purchased:
                completed(transaction: transaction)
            case .restored:
                print("Restored donation")
            @unknown default:
                fatalError()
            }
        }
    }
    
    private func failed(transaction: SKPaymentTransaction) {
        
        if let transactionError = transaction.error as NSError? {
            
            if transactionError.code != SKError.paymentCancelled.rawValue {
                print("Ошибка транзакции: \(transaction.error!.localizedDescription)")
            }
        }
        paymentQueue.finishTransaction(transaction)
    }

    private func completed(transaction: SKPaymentTransaction) {
        NotificationCenter.default.post(
            name: NSNotification.Name(transaction.payment.productIdentifier),
            object: nil
        )
        paymentQueue.finishTransaction(transaction)
    }
    
    private func restored(transaction: SKPaymentTransaction) {
        paymentQueue.finishTransaction(transaction)
    }
}

extension ConsumableManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest,
                         didReceive response: SKProductsResponse) {
        self.products = response.products
        
        products.forEach {
            print($0.localizedTitle)
        }
        
        if products.count > 0 {
            NotificationCenter.default.post(
                name: NSNotification.Name(
                    ConsumableManager.consumableNotificationIdentifier
                ),
                object: nil
            )
        }
    }
}
