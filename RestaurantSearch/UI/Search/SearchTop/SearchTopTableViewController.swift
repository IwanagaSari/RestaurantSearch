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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        freewordSearchBar.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        freewordSearchBar.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        freewordSearchBar.resignFirstResponder()
        return true
    }
}
