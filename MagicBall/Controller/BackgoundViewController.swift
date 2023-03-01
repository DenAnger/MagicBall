//
//  BackgoundViewController.swift
//  MagicBall
//
//  Created by Denis Abramov on 18.03.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import UIKit

class BackgoundViewController: UIViewController, UICollectionViewDataSource,
                               UICollectionViewDelegate {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    let colorBackgound = ColorText()
    
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveDidSelectBackgroundColor()
    }
    
    // Запускается после закрытия экрана
    override func viewWillDisappear(_ animated: Bool) {
        saveSelectedColorBackground()
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return colorBackgound.colorDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell",
                                                      for: indexPath)
        
        let imageName = colorBackgound.colorDict[indexPath.row]
        cell.backgroundColor = imageName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        backgroundView.backgroundColor = colorBackgound.colorDict[indexPath.row]
    }
    
    // MARK: - Methods
    
    func saveSelectedColorBackground() {
        
        if backgroundView.backgroundColor != .systemBackground {
            defaults.setColor(backgroundView.backgroundColor!,
                              forKey: "nameColorForBackground")
        }
    }
    
    func saveDidSelectBackgroundColor() {
        
        if let nameColorForBackground = defaults.savedColor(forKey: "nameColorForBackground") {
            backgroundView.backgroundColor = nameColorForBackground
        }
    }
}
