//
//  SettingsTableViewController.swift
//  MagicBall
//
//  Created by Denis Abramov on 18.01.2022.
//  Copyright © 2022 Denis Abramov. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let settings = ["Цвет текста",
                    "Цвет большого шара",
                    "Цвет маленького шара",
                    "Фон",
                    "Подписка",
                    "Поддержать проект"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingsTableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "textCell",
                                                 for: indexPath)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "bigBallCell",
                                                 for: indexPath)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "smallBallCell",
                                                 for: indexPath)
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "backgroundCell",
                                                 for: indexPath)
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "subCell",
                                                 for: indexPath)
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "donationCell",
                                                 for: indexPath)
        }
        
        var content = cell.defaultContentConfiguration()
        content.text = settings[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
}
