//
//  ShopInfoTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/06/03.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class ShopInfoTests: XCTestCase {
    private let shop = Shop(id: "",
                            name: "店の名前",
                            nameKana: "カタカナ",
                            latitude: "33.593713",
                            longitude: "130.407861",
                            category: "カテゴリー",
                            imageUrl: Shop.Image(shopImage1: "https://uds.gnst.jp/rest/img/e0p4w8tb0000/t_0n5s.png",
                                                 shopImage2: "",
                                                 qrcode: "https://c-r.gnst.jp/tool/qr/?id=h598811&q=6"),
                            address: "福岡市東区馬出",
                            tel: "092-642-6900",
                            opentime: "18:00~24:00",
                            pr: Shop.Pr(prShort: "すっごく美味しいですよ〜"),
                            code: Shop.Code(genre: ["広島風お好み焼き", ""]))
    
    func testInstantiate() {
        let vc = ShopInfoViewController.instantiate(shop: shop)
        XCTAssertNotNil(vc)
    }
}
