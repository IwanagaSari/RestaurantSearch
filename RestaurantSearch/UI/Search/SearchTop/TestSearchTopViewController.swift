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
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
        
        UIView.animate(withDuration: 1.5, animations: { () -> Void in
            self.bottomView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 0.3)
        })
//        self.bottomView.center = self.view.center
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: .autoreverse, animations: {
//            self.bottomView.center.y += 85.0
//
//        }, completion: nil)
    }
}
