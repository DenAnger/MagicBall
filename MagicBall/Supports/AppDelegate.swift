//
//  AppDelegate.swift
//  MagicBall
//
//  Created by Denis Abramov on 12.06.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        SubManager.shared.setupPurchases { success in
            
            if success {
                print("can make payments sub")
                SubManager.shared.getProducts()
            }
        }
        
        ConsumableManager.shared.setupPurchases { success in
            
            if success {
                print("can make payments consumable")
                ConsumableManager.shared.getProducts()
            }
        }
        return true
    }
}
