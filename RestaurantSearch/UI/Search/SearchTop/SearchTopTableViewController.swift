//
//  SearchTopTableViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/04/22.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit

final class SearchTopTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var freewordSearchBar: UITextField!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var sceneLabel: UILabel!
    var areaInfo: Town?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let areaInfo = areaInfo {
            areaLabel.text = areaInfo.areanameS
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            performSegue(withIdentifier: "toAreaSelect", sender: self)
        default:
            return
        }
    }
    
    // MARK: - Actions

    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        freewordSearchBar.resignFirstResponder()
    }
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        print("タップされたよ")
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        freewordSearchBar.resignFirstResponder()
        return true
    }
}
