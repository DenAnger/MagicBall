//
//  BigBallViewController.swift
//  MagicBall
//
//  Created by Denis Abramov on 20.04.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import UIKit

class BigBallViewController: UIViewController, UICollectionViewDataSource,
                             UICollectionViewDelegate {
    
    @IBOutlet var bigBallCollectionView: UICollectionView!
    @IBOutlet var bigBallImageView: UIImageView!
    
    let freeBigBalls = ["BigRedBall", "BigYellowBall", "BigGreenBall",
                        "BigBrownBall", "BigBlueBall", "BigPinkBall",
                        "BigBlackBall","BigWhiteBall"]
    let subBigBalls = ["No name"]
    
    var allBigBalls = [""]
    
    let testAllArray = 0
    
    /// Количество объектов на строку
    let itemsPerRow: CGFloat = 2
    /// Отступы: сверху, слева, снизу, справа
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveDidSelectBigBall()
        arrayBigBalls()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveSelectedBigBall()
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return allBigBalls.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "bigBallCell",
            for: indexPath
        ) as! BigBallCell
        
        let imageName = allBigBalls[indexPath.item]
        let image = UIImage(named: imageName)
        
        cell.bigBallCollectionImageView.image = image
        cell.backgroundColor = .orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        bigBallImageView.image = UIImage(named: allBigBalls[indexPath.item])
    }

    // MARK: - Methods
    
    func saveSelectedBigBall() {

        if bigBallImageView.image != UIImage(named: "No name") {
            defaults.setImage(bigBallImageView.image!,
                              forKey: "nameImageForBigBall")
        }
    }

    func saveDidSelectBigBall() {

        if let nameImageForBigBall = defaults.savedImage(forKey: "nameImageForBigBall") {
            bigBallImageView.image = nameImageForBigBall
        }
    }
    
    /// Складывает количество свободных шаров и шаров по подписке
    func arrayBigBalls() {
        
        // Если статус пользователя будет равен 1, то к бесплатным шарам
        // добавятся шары по подписке
        if testAllArray == 1 {
            allBigBalls = freeBigBalls + subBigBalls
        } else {
            allBigBalls = freeBigBalls
        }
    }
}

// Расстояние межджу ячейками и размер
extension BigBallViewController: UICollectionViewDelegateFlowLayout {
    
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
