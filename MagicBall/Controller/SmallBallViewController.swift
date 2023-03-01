//
//  SmallBallViewController.swift
//  MagicBall
//
//  Created by Denis Abramov on 06.05.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import UIKit

class SmallBallViewController: UIViewController, UICollectionViewDataSource,
                               UICollectionViewDelegate {
    
    @IBOutlet var smallBallCollectionView: UICollectionView!
    @IBOutlet var smallBallImageView: UIImageView!
    
    let freeSmallBalls = ["SmallRedBall", "SmallYellowBall", "SmallGreenBall",
                          "SmallBrownBall", "SmallBlueBall", "SmallPinkBall",
                          "SmallBlackBall", "SmallWhiteBall"]
    let subSmallBalls = ["No name"]
    
    var allSmallBalls = [""]
    
    let testAllArray = 1
    
    /// Количество объектов на строку
    let itemsPerRow: CGFloat = 2
    /// Отступы: сверху, слева, снизу, справа
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arraySmallBalls()
        saveDidSelectSmallBall()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveSelectedSmallBall()
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return allSmallBalls.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "smallBallCell",
            for: indexPath
        ) as! SmallBallCell
        
        let imageName = allSmallBalls[indexPath.item]
        let image = UIImage(named: imageName)
        
        cell.smallBallCollectionImageView.image = image
        cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        smallBallImageView.image = UIImage(named: allSmallBalls[indexPath.item])
    }

    // MARK: - Methods
    
    func saveSelectedSmallBall() {

        if smallBallImageView.image != UIImage(named: "No name") {
            defaults.setImage(smallBallImageView.image!,
                              forKey: "nameImageForSmallBall")
        }
    }

    func saveDidSelectSmallBall() {

        if let nameImageForSmallBall = defaults.savedImage(forKey: "nameImageForSmallBall") {
            smallBallImageView.image = nameImageForSmallBall
        }
    }
    
    func arraySmallBalls() {
        
        if testAllArray == 1 {
            allSmallBalls = freeSmallBalls + subSmallBalls
        } else {
            allSmallBalls = freeSmallBalls
        }
    }
}

// Расстояние межджу ячейками и размер
extension SmallBallViewController: UICollectionViewDelegateFlowLayout {
    
    // размер ячейки
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// отсутпы по ширине
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        /// Доступная ширина
        let availableWidth = collectionView.frame.width - paddingWidth
        /// Ширина на объект
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    // Отступы сверху, снизу, справа, слева
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
