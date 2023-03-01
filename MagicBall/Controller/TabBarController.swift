//
//  TabBarController.swift
//  MagicBall
//
//  Created by Denis Abramov on 13.03.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var textColor: UIColor = .cyan
    
    var background: UIColor = .white
    
    var bigBallImage = UIImage(named: "BigBlackBall")
    var smallBallImage = UIImage(named: "SmallGreenBall")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
