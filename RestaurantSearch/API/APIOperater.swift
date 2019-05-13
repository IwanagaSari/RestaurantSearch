//
//  APIOperater.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/05/09.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation
import Alamofire

final class APIOperater {
    let parameters = [
        "keyid": "9e168ecbfa31f841eb3a8bc16045a424"
    ]
    
    func fetchresponse<Responsetype: Decodable>(url: String, success: @escaping (Responsetype) -> Void, failure: @escaping (Error) -> Void) {
        Alamofire.request(url, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(Responsetype.self, from: data)
                    success(result)
                } catch {
                    failure(error)
                }
            case .failure(let err):
                failure(err)
            }
        }
    }
    
    /// エリアの取得
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/AreaSearchAPI/v3/"
        fetchresponse(url: url, success: success, failure: failure)
    }
    
    /// 都道府県の取得
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/PrefSearchAPI/v3/"
        fetchresponse(url: url, success: success, failure: failure)
    }
    
    /// 市の取得
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaLargeSearchAPI/v3/"
        fetchresponse(url: url, success: success, failure: failure)
    }
    
    /// 町の取得
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaSmallSearchAPI/v3/"
        fetchresponse(url: url, success: success, failure: failure)
    }
}
