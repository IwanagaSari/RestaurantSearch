//
//  APIOperater.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/05/09.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation
import Alamofire

protocol APIType {
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getShop(townCode: String, freeword: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getShopByID(shopID: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void)
}

final class APIOperater: APIType {
    private let commonParameters: [String: Any] = [
        "keyid": "ca11c104693ded38efb1a2abdd2aea07"
    ]
    
    private func fetchResponse<Responsetype: Decodable>(url: String, parameters: [String: Any], success: @escaping (Responsetype) -> Void, failure: @escaping (Error) -> Void) {
        let finalParameters = commonParameters.merging(parameters) { $1 }
        
        Alamofire.request(url, parameters: finalParameters).responseData { response in
            
            // ぐるなびAPI上のエラーがある場合
            if (response.response?.statusCode)! >= 300 || (response.response?.statusCode)! < 200{
                
            // ぐるなびAPI上のエラーがない場合
            } else {
                let result = response.result.flatMap({ try JSONDecoder().decode(Responsetype.self, from: $0) })
                switch result {
                case .success(let object):
                    success(object)
                case .failure(let error): // ぐるなびAPI上のエラーはないが、デコード時のエラーがある場合
                    failure(error)
                }
            }
        }
    }
    
    /// エリアの取得
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/AreaSearchAPI/v3/"
        fetchResponse(url: url, parameters: [:], success: success, failure: failure)
    }
    
    /// 都道府県の取得
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/PrefSearchAPI/v3/"
        fetchResponse(url: url, parameters: [:], success: success, failure: failure)
    }
    
    /// 市の取得
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaLargeSearchAPI/v3/"
        fetchResponse(url: url, parameters: [:], success: success, failure: failure)
    }
    
    /// 町の取得
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaSmallSearchAPI/v3/"
        fetchResponse(url: url, parameters: [:], success: success, failure: failure)
    }
    
    /// エリア・フリーワードからお店情報の取得
    func getShop(townCode: String, freeword: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
        let parameters: [String: Any] = [
            "areacode_s": townCode,
            "freeword": freeword,
            "hit_per_page": 100
        ]
        fetchResponse(url: url, parameters: parameters, success: success, failure: failure)
    }
    
    /// IDからお店情報を取得
    func getShopByID(shopID: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
        let parameters = [
            "id": shopID
        ]
        fetchResponse(url: url, parameters: parameters, success: success, failure: failure)
    }
}
