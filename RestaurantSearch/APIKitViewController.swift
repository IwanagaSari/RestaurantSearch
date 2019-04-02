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
        typealias Response = Area

        var path: String {
            return "/v3/"
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var parameters: Any? {
            return [
                "keyid": "9e168ecbfa31f841eb3a8bc16045a424"
            ]
        }
        // 作成したJSONDataParserをパーサとして適用する
        var dataParser: DataParser {
            return DecodableDataParser()
        }
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> FetchRepositoryRequest.Response {
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            return try JSONDecoder().decode(Response.self, from: data)
        }
    }
}

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data   // ここではデコードせずにそのまま返す
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
