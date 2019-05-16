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
}

class DummyAPI: APIType {
    let area = AreaResponseBody(area: [Area(areaCode: "000", areaName: "九州")])
    var prefecture = PrefectureResponseBody(pref: [Prefecture(prefCode: "111",
                                                              prefName: "福岡県",
                                                              areaCode: "222")])
    var city = CityResponseBody(gareaLarge: [City(areacodeL: "333",
                                                  areanameL: "大濠・六本松・桜坂",
                                                  pref: City.Pref(prefCode: "444",
                                                                  prefName: "福岡県"))])
    var town = TownResponseBody(gareaSmall: [Town(areacodeS: "555",
                                                  areanameS: "桜坂・小笹",
                                                  gareaLarge: Town.AreaL(areacodeL: "666",
                                                                         areanameL: "大濠・六本松・桜坂"))])
    //var error: Error?

    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(area)//; failure(error!)
    }

    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(prefecture)//; failure(error!)
    }

    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(city)//; failure(error!)
    }

    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(town)//; failure(error!)
    }
}

final class APIOperater: APIType {
    let parameters = [
        "keyid": "9e168ecbfa31f841eb3a8bc16045a424"
    ]
    
    private func fetchResponse<Responsetype: Decodable>(url: String, success: @escaping (Responsetype) -> Void, failure: @escaping (Error) -> Void) {
        Alamofire.request(url, parameters: parameters).responseData { response in
            let result = response.result.flatMap({ try JSONDecoder().decode(Responsetype.self, from: $0) })
            switch result {
            case .success(let object):
                success(object)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    /// エリアの取得
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/AreaSearchAPI/v3/"
        fetchResponse(url: url, success: success, failure: failure)
    }
    
    /// 都道府県の取得
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/PrefSearchAPI/v3/"
        fetchResponse(url: url, success: success, failure: failure)
    }
    
    /// 市の取得
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaLargeSearchAPI/v3/"
        fetchResponse(url: url, success: success, failure: failure)
    }
    
    /// 町の取得
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaSmallSearchAPI/v3/"
        fetchResponse(url: url, success: success, failure: failure)
    }
}
