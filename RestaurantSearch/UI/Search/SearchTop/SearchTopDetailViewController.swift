//
//  SearchTopDetailViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/07/02.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class SearchTopDetailViewController: UITableViewController {
    @IBOutlet weak private var freewordTextField: UITextField!
    @IBOutlet weak private var areaSelectButton: UIButton!
    @IBOutlet weak private var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.height - view.safeAreaInsets.top) / 3 // 3は使っているセルの数
    }
    
    func layout() {
        areaSelectButton.layer.cornerRadius = 5.0
        searchButton.layer.cornerRadius = 5.0
    }
}
