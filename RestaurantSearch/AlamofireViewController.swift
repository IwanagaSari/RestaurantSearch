//
//  AlamofireViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/03/28.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireViewController: UIViewController {
    
    override func viewDidLoad() {
        let parameters = [
            "keyid": "9e168ecbfa31f841eb3a8bc16045a424"
        ]
        Alamofire.request("https://api.gnavi.co.jp/master/AreaSearchAPI/v3/", parameters: parameters).responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")                         
            
            switch response.result {
            case .success(let response):
                print("成功：\(response)")
            case .failure(let err):
                print("失敗：\(err)")
            }
        }
    }
    
}
