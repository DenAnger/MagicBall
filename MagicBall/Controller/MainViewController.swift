//
//  MainViewController.swift
//  MagicBall
//
//  Created by Denis Abramov on 12.06.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var bigBall: UIImageView!
    @IBOutlet var smallBall: UIImageView!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    private var answer = Answer(rawValue: "")
    
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smallBall.isHidden = true
        answerLabel.isHidden = true
        
        changeSettings()
        saveSelectedColors()
    }
    
    // Активируется после изменения данных
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateRandomAnswer()
        saveDidSelectColors()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype,
                              with event: UIEvent?) {
        
        if motion == .motionShake {
            UIView.transition(with: answerLabel,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.answerLabel.isHidden = true },
                              completion: nil)
            
            UIView.transition(with: smallBall,
                              duration: 1,
                              options: .transitionCrossDissolve,
                              animations: { self.smallBall.isHidden = true },
                              completion: { (success: Bool) -> Void in
                self.animateRandomAnswer()
            })
        }
    }
    
    func animateRandomAnswer() {
        answer = .allCases.randomElement()
        let randomCase = (answer?.rawValue)!
        animateSmallBallInWithText(text: randomCase)
    }

    func animateSmallBallInWithText(text: String) {
        answerLabel.text = NSLocalizedString(text, comment: "")
        UIView.transition(with: smallBall,
                          duration: 1,
                          options: .transitionCrossDissolve,
                          animations: { self.smallBall.isHidden = false },
                          completion: nil)
        
        UIView.transition(with: answerLabel,
                          duration: 1.5,
                          options: .transitionCrossDissolve,
                          animations: { self.answerLabel.isHidden = false },
                          completion: nil)
    }
    
    func changeSettings() {
        let tabBar = tabBarController as! TabBarController
        answerLabel.textColor = tabBar.textColor
        bigBall.image = tabBar.bigBallImage
        smallBall.image = tabBar.smallBallImage
    }
    
    func saveSelectedColors() {
        
        if answerLabel.textColor != .cyan {
            defaults.setColor(answerLabel.textColor, forKey: "nameColorForText")
        }
        
        if backgroundView.backgroundColor != .systemBackground {
            defaults.setColor(backgroundView.backgroundColor!,
                              forKey: "nameColorForBackground")
        }
        
        if bigBall.image != UIImage(named: "BigBlackBall") {
            defaults.setImage(bigBall.image!, forKey: "nameImageForBigBall")
        }
        
        if smallBall.image != UIImage(named: "SmallGreenBall") {
            defaults.setImage(smallBall.image!, forKey: "nameImageForSmallBall")
        }
    }
    
    func saveDidSelectColors() {
        
        if let nameColorForText = defaults.savedColor(forKey: "nameColorForText") {
            answerLabel.textColor = nameColorForText
        }
        
        if let nameColorForBackground = defaults.savedColor(forKey: "nameColorForBackground") {
            backgroundView.backgroundColor = nameColorForBackground
        }
        
        if let nameImageForBigBall = defaults.savedImage(forKey: "nameImageForBigBall") {
            bigBall.image = nameImageForBigBall
        }
        
        if let nameImageForSmallBall = defaults.savedImage(forKey: "nameImageForSmallBall") {
            smallBall.image = nameImageForSmallBall
        }
    }
}
