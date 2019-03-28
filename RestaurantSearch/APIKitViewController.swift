//
//  APIKitViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/03/28.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit
import APIKit

class APIKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = API.FetchRepositoryRequest()
        Session.send(request) { result in
            //request.response(from: <#T##Any#>, urlResponse: <#T##HTTPURLResponse#>)
            switch result {
                
            case .success(let response):
                
                print("成功！！\(response)")
                
            case .failure(let err):
                
                print("失敗してるよ\(err)")
                print(err.localizedDescription)
                
            }
        }

    }
    
}

protocol GurunaviRequest: Request {  //APIKitが持っているRequestプロトコル
}

extension GurunaviRequest {
    var baseURL: URL {
        return URL(string: "https://api.gnavi.co.jp/master/AreaSearchAPI")!
    }
}

class API {
    struct FetchRepositoryRequest: GurunaviRequest {
        typealias Response = [Any]

        var path: String {
            return "/v3/"
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var parameters: [String: String] {
            return [
                "keyid": "9e168ecbfa31f841eb3a8bc16045a424",
            ]
        }
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> FetchRepositoryRequest.Response {
            return try Area(object: object)
        }
    }
}

public enum ResponseError: Error {
    /// Indicates the session adapter returned `URLResponse` that fails to down-cast to `HTTPURLResponse`.
    case nonHTTPURLResponse(URLResponse?)
    
    /// Indicates `HTTPURLResponse.statusCode` is not acceptable.
    /// In most cases, *acceptable* means the value is in `200..<300`.
    case unacceptableStatusCode(Int)
    
    /// Indicates `Any` that represents the response is unexpected.
    case unexpectedObject(Any)
}
