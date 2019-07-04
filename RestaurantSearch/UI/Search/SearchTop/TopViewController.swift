//
//  TopViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/24.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class TopViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // NavigationBar 非表示
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // NavigationBar 表示
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = false
    }
}
