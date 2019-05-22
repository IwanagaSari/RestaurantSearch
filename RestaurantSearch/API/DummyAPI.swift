//
//  DummyAPI.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/05/20.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

class DummyAPI: APIType {
    var area = AreaResponseBody(area: [Area(areaCode: "000", areaName: "九州")])
    var prefecture = PrefectureResponseBody(pref: [Prefecture(prefCode: "111",
                                                              prefName: "福岡県",
                                                              areaCode: "222")])
    var city = CityResponseBody(city: [City(cityCode: "333",
                                                  cityName: "大濠・六本松・桜坂",
                                                  pref: City.Pref(prefCode: "444",
                                                                  prefName: "福岡県"))])
    var town = TownResponseBody(town: [Town(townCode: "555",
                                                  townName: "桜坂・小笹",
                                                  city: Town.AreaL(cityCode: "666",
                                                                         cityName: "大濠・六本松・桜坂"))])
    
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(area)
    }
    
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(prefecture)
    }
    
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(city)
    }
    
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(town)
    }
}
