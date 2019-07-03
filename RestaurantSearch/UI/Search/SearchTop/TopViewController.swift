//
//  TopViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/24.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
}
