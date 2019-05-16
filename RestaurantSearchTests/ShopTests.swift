//
//  ShopTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/05/16.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

class ShopTests: XCTestCase {
    
    func testShopDecode() throws {
        let json = """
{
    "@attributes": {
                "order": 0
    },
    "id": "fap1004",
    "update_date": "2019-04-02T02:33:06+09:00",
    "name": "今生焼 大川店",
    "image_url": {
        "shop_image1": "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5c.jpg",
        "shop_image2": "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5d.jpg",
        "qrcode": "https://c-r.gnst.jp/tool/qr/?id=fap1004&q=6"
    },
    "address": "〒831-0031 福岡県大川市大字上巻字野口430-1",
    "tel": "050-3464-8707",
}
"""
        let shop = try JSONDecoder().decode(Shop.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(shop.name, "今生焼 大川店")
        XCTAssertEqual(shop.imageUrl.shopImage1, "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5c.jpg")
        XCTAssertEqual(shop.address, "〒831-0031 福岡県大川市大字上巻字野口430-1")
        XCTAssertEqual(shop.tel, "050-3464-8707")
    }
    
    func testShopResponseBodyDecode() throws {
        let json = """
{
    "@attributes": {
        "api_version": "v3"
    },
    "total_hit_count": 50213,
    "hit_per_page": 10,
    "page_offset": 1,
    "rest": [
        {
            "@attributes": {
                "order": 0
            },
            "id": "f082211",
            "update_date": "2019-05-12T14:00:14+09:00",
            "name": "博多うまかんもん 小野 博多本店",
            "name_kana": "ハカタウマカンモンオノ ハカタホンテン",
            "latitude": "33.589188",
            "longitude": "130.422632",
            "category": "博多お祭り居酒屋",
            "url": "https://r.gnavi.co.jp/e77btpdb0000/?ak=7CsVrTaV3F2RedNSaEr9ctXRf%2BI3gYZZeM9BIuJEVYY%3D",
            "url_mobile": "http://mobile.gnavi.co.jp/shop/f082211/?ak=7CsVrTaV3F2RedNSaEr9ctXRf%2BI3gYZZeM9BIuJEVYY%3D",
            "coupon_url": {
                "pc": "https://r.gnavi.co.jp/e77btpdb0000/coupon/",
                "mobile": "http://mobile.gnavi.co.jp/shop/f082211/coupon"
            },
            "image_url": {
                "shop_image1": "https://uds.gnst.jp/rest/img/e77btpdb0000/t_001x.jpg",
                "shop_image2": "https://uds.gnst.jp/rest/img/e77btpdb0000/t_001y.jpg",
                "qrcode": "https://c-r.gnst.jp/tool/qr/?id=f082211&q=6"
            },
            "address": "〒812-0013 福岡県福岡市博多区博多駅東2-1-24 ギャラリーハカタビルB1",
            "tel": "050-3464-1508",
            "parking_lots": ""
        }
    ]
}
"""
        let body = try JSONDecoder().decode(ShopResponseBody.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(body.shop.count, 1)
    }
}
