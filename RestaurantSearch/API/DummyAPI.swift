//
//  DummyAPI.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/05/20.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

class DummyAPI: APIType {
    var area = AreaResponseBody(areaList: [Area(areaCode: "000", areaName: "九州")])
    var prefecture = PrefectureResponseBody(prefectureList: [Prefecture(prefCode: "111",
                                                                        prefName: "福岡県",
                                                                        areaCode: "222")])
    var city = CityResponseBody(cityList: [City(cityCode: "333",
                                                cityName: "大濠・六本松・桜坂",
                                                pref: City.Pref(prefCode: "444",
                                                                prefName: "福岡県"))])
    var town = TownResponseBody(townList: [Town(townCode: "555",
                                                townName: "桜坂・小笹",
                                                city: Town.AreaL(cityCode: "666",
                                                                 cityName: "大濠・六本松・桜坂"))])
    var shop = ShopResponseBody(shop: [Shop(id: "fap1004",
                                            name: "店の名前",
                                            nameKana: "カタカナ",
                                            latitude: "緯度",
                                            longitude: "経度",
                                            category: "カテゴリー",
                                            imageUrl: Shop.Image(shopImage1: "https://uds.gnst.jp/rest/img/e0p4w8tb0000/t_0n5s.png",
                                                                 shopImage2: "",
                                                                 qrcode: "https://c-r.gnst.jp/tool/qr/?id=h598811&q=6"),
                                            address: "福岡市東区馬出",
                                            tel: "092-642-6900",
                                            opentime: "18:00~24:00",
                                            pr: Shop.Pr(prShort: "すっごく美味しいですよ〜"),
                                            code: Shop.Code(genre: ["広島風お好み焼き", ""]))])
    
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
    
    func getShop(townCode: String, freeword: String, shopID: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(shop)
    }
}
