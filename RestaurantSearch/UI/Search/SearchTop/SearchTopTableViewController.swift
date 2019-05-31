//
//  SearchTopTableViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/04/22.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit

final class SearchTopTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak private var freewordSearchBar: UITextField!
    @IBOutlet weak private var areaLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var sceneLabel: UILabel!
    private var town: Town!
    
    static func instantiate(town: Town) -> SearchTopTableViewController {
        let vc = UIStoryboard(name: "SearchTop", bundle: nil).instantiateInitialViewController() as! SearchTopTableViewController
        vc.town = town
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateArea()
    }
    
    private func updateArea() {
            areaLabel.text = town.townName
    }
    
    private func showAreaSelect() {
        let vc = AreaSelectViewController.instantiate()
        show(vc, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            showAreaSelect()
        default:
            return
        }
    }
    
    // MARK: - Actions

    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        freewordSearchBar.resignFirstResponder()
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        freewordSearchBar.resignFirstResponder()
        return true
    }
}
