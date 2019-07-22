//
//  ShopMapViewControllerTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/06/03.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class ShopMapViewControllerTests: XCTestCase {
    
    func testInstantiate() {
        let shop = Shop(id: "h793032",
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
                        holiday: "不定休日あり",
                        pr: Shop.Pr(prShort: "すっごく美味しいですよ〜",
                                    prLong: "今泉に11月NEWオープン!!!\n貸切宴会や飲み会、結婚式二次会にオススメ！\n・交通アクセス\n西鉄天神駅より徒歩3分\n・プラン\n地域最安値の2,500円～\n・席\n着席70名、立席120名\n・特典\n①カラオケ無料\n②新郎新婦無料"),
                        code: Shop.Code(genre: ["広島風お好み焼き", ""]))
        let vc = ShopMapViewController.instantiate(shop: shop)
        XCTAssertNotNil(vc)
    }
}
