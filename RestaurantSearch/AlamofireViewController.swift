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
        let url = "https://api.gnavi.co.jp/master/AreaSearchAPI"
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
                } catch {
                    print(error)
                }
            case .failure(let err):
                print("失敗：\(err)")
            }
        }
    
    }
    
}

protocol RequestProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var parameters: Alamofire.Parameters? { get }
    var manager: Alamofire.SessionManager { get }
    var headers: Alamofire.HTTPHeaders? { get }
}

struct FetchRequest: RequestProtocol {
    var headers: HTTPHeaders?
    
    var manager: SessionManager
    
    var baseURL: String {
        return "https://api.gnavi.co.jp/master/AreaSearchAPI"
    }
    var parameters: Parameters? {
        return [
            "keyid": "9e168ecbfa31f841eb3a8bc16045a424"
        ]
    }
    
    var path: String {
        return "/v3/"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func createRequest(baseURL: String, parameters: Parameters, path: String, method: HTTPMethod, encoding: ParameterEncoding, manager: SessionManager) -> Alamofire.Request {
        return manager.request(baseURL, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}
