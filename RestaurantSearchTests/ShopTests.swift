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
}
