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
    
    var areaResponseBody: AreaResponseBody?
    var error: Error?
    
    override func viewDidLoad() {
        
        getAreaAPI(success: { areaResponseBody in
            self.areaResponseBody = areaResponseBody
            if let area = areaResponseBody?.area[0] {
                print("エリアの名前：\(area.areaName)")
            }
        }, failure: {
            
        })

    }
    
    func getAreaAPI(success: @escaping (AreaResponseBody?) -> Void, failure: @escaping () -> Void) {
        let parameters = [
            "keyid": "9e168ecbfa31f841eb3a8bc16045a424"
        ]
        let url = "https://api.gnavi.co.jp/master/AreaSearchAPI/v3/"
        Alamofire.request(url,parameters: parameters).responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            
            switch response.result {
            case .success(_):
                do {
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(AreaResponseBody.self, from: data)
                    print("結果：\(result)")
                    success(result)
                } catch {
                    print(error)
                    failure()
                }
            case .failure(let err):
                print("失敗：\(err)")
                failure()
            }
        }
    }
    
}
