//
//  UserDefaults.swift
//  MagicBall
//
//  Created by Denis Abramov on 14.03.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    func setColor(_ color: UIColor, forKey key: String) {
        try? set(NSKeyedArchiver.archivedData(withRootObject: color,
                                              requiringSecureCoding: true),
                 forKey: key)
    }
    
    func savedColor(forKey key: String) -> UIColor? {
        
        guard let data = data(forKey: key) else {
            return nil
        }
        
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self,
                                                       from: data)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        try? set(NSKeyedArchiver.archivedData(withRootObject: image,
                                              requiringSecureCoding: true),
                 forKey: key)
    }
    
    func savedImage(forKey key: String) -> UIImage? {
        
        guard let data = data(forKey: key) else {
            return nil
        }
        
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self,
                                                       from: data)
    }
}
