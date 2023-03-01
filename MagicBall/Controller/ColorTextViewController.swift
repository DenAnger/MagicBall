//
//  ColorTextViewController.swift
//  MagicBall
//
//  Created by Denis Abramov on 18.01.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import UIKit

class ColorTextViewController: UIViewController, UITableViewDataSource,
                               UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var textColorLabel: UILabel!
    
    private let colorText = ColorText()
    
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeTextColor()
        saveDidSelectTextColor()
    }
    
    // Вызывается после закрытия контроллера
    override func viewWillDisappear(_ animated: Bool) {
        changeTextColor()
        saveSelectedTextColor()
    }
    
    // MARK: - tableView
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return colorText.data.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell",
                                                 for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = colorText.data[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        textColorLabel.text = colorText.data[indexPath.row]
        textColorLabel.textColor = colorText.colorDict[indexPath.row]
    }
    
    // MARK: - Methods
    
    func changeTextColor() {
        textColorLabel.text = "Change color"
    }
    
    func saveSelectedTextColor() {
        
        if textColorLabel.textColor != .clear {
            defaults.setColor(textColorLabel.textColor,
                              forKey: "nameColorForText")
        }
    }
    
    func saveDidSelectTextColor() {

        if let nameColorForText = defaults.savedColor(forKey: "nameColorForText") {
            textColorLabel.textColor = nameColorForText
        }
    }
}
