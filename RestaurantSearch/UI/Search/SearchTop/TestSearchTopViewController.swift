//
//  TestSearchTopViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/06/13.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit

class TestSearchTopViewController: UIViewController {
    @IBOutlet weak private var bottomView: UIView!
    @IBOutlet weak private var freewordTextField: UITextField!
    @IBOutlet weak private var areaSelectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarSetting()
    }
    
    private func navigationBarSetting() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
}
