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
    var prefectureResponseBody: PrefectureResponseBody?
    var cityResponseBody: CityResponseBody?
    var townResponseBody: TownResponseBody?
    var error: Error?
    let parameters = [
        "keyid": "9e168ecbfa31f841eb3a8bc16045a424"
    ]
    
    override func viewDidLoad() {
        
        getAreaAPI(success: { areaResponseBody in
            self.areaResponseBody = areaResponseBody
            if let area = areaResponseBody?.area[0] {
                print("エリアの名前：\(area.areaName)")
            }
        }, failure: { error in
            if let error = error {
                print(error)
            }
        })
        
        getPrefectureAPI(success: { prefectureResponseBody in
            self.prefectureResponseBody = prefectureResponseBody
            if let pref = prefectureResponseBody?.pref[0] {
                print("都道府県の名前：\(pref.prefName)")
            }
        }, failure: { error in
            if let error = error {
                print(error)
            }
        })
        
        getCityAPI(success: { cityResponseBody in
            self.cityResponseBody = cityResponseBody
            if let city = cityResponseBody?.garea_large[0] {
                print("市の名前：\(city.areanameL)")
            }
        }, failure: { error in
            if let error = error {
                print(error)
            }
        })
        
        getTownAPI(success: { townResponseBody in
            self.townResponseBody = townResponseBody
            if let town = townResponseBody?.garea_small[0] {
                print("町の名前：\(town.areanameS)")
            }
        }, failure: { error in
            if let error = error {
                print(error)
            }
        })
    }
    
    func fetchresponse<Responsetype: Decodable>(url: String, success: @escaping (Responsetype?) -> Void, failure: @escaping (Error?) -> Void) {
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            switch response.result {
                case .success(_):
                    do {
                        guard let data = response.data else { return }
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
    func getAreaAPI(success: @escaping (AreaResponseBody?) -> Void, failure: @escaping (Error?) -> Void) {
        let url = "https://api.gnavi.co.jp/master/AreaSearchAPI/v3/"
        fetchresponse(url: url, success: success, failure: failure)
    }
    
    /// 都道府県の取得
    func getPrefectureAPI(success: @escaping (PrefectureResponseBody?) -> Void, failure: @escaping (Error?) -> Void) {
        let url = "https://api.gnavi.co.jp/master/PrefSearchAPI/v3/"
        fetchresponse(url: url, success: success, failure: failure)
    }
    
    /// 市の取得
    func getCityAPI(success: @escaping (CityResponseBody?) -> Void, failure: @escaping (Error?) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaLargeSearchAPI/v3/"
        fetchresponse(url: url, success: success, failure: failure)
    }
    
    /// 町の取得
    func getTownAPI(success: @escaping (TownResponseBody?) -> Void, failure: @escaping (Error?) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaSmallSearchAPI/v3/"
        fetchresponse(url: url, success: success, failure: failure)
    }
}
