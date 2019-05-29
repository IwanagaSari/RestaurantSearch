//
//  ShopTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/05/16.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class ShopTests: XCTestCase {
    
    func testShopDecode() throws {
        let json = """
{
    "@attributes": {
                "order": 0
    },
    "id": "fap1004",
    "update_date": "2019-04-02T02:33:06+09:00",
    "name": "今生焼 大川店",
    "name_kana": "コンジョウヤキ オオカワテン",
    "latitude": "33.202820",
    "longitude": "130.388015",
    "category": "鉄板×広島流お好み焼",
    "url": "https://r.gnavi.co.jp/a9b68a5k0000/?ak=mM7PvOuIqCpuMW1wCJUEgAbSJS0EV6pS1Nwx%2F%2B8qohc%3D",
    "url_mobile": "http://mobile.gnavi.co.jp/shop/fap1004/?ak=mM7PvOuIqCpuMW1wCJUEgAbSJS0EV6pS1Nwx%2F%2B8qohc%3D",
    "coupon_url": {
        "pc": "",
        "mobile": ""
    },
    "image_url": {
        "shop_image1": "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5c.jpg",
        "shop_image2": "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5d.jpg",
        "qrcode": "https://c-r.gnst.jp/tool/qr/?id=fap1004&q=6"
    },
    "address": "〒831-0031 福岡県大川市大字上巻字野口430-1",
    "tel": "050-3464-8707",
    "tel_sub": "0944-87-6554",
    "fax": "0944-87-6554",
    "opentime": "月～日 11:00～21:00",
    "holiday": "不定休日あり\n※※ゆめタウン大川に準ずる",
    "access": {
        "line": "西鉄天神大牟田線",
        "station": "蒲池駅",
        "station_exit": "",
        "walk": "46",
        "note": ""
    },
    "parking_lots": "",
    "pr": {
        "pr_short": "【大川市上巻野口エリア】 ゆめタウン大川1F 広島のソウルフード“お好み焼”と鉄板料理を楽しめる『今生焼』",
        "pr_long": "広島出身のオーナーが「広島の味をもっと知ってほしい」との想いでオープンした当店。\n広島県民に愛され続けるお好み焼をはじめ、呉名物のがんす、肉厚な牡蠣など\n福岡にいながら広島を存分に味わえるメニューを揃えました。\n◆おすすめ料理◆\n・広島流お好み焼 王道 830円（税込）\n・広島“呉”名物がんす焼 480円（税込）\n・運命のサイコロ素敵（ステーキ） 1,150円（税込）\nお買い物途中のお食事にいかがでしょうか！"
    },
    "code": {
        "areacode": "AREA140",
        "areaname": "九州",
        "prefcode": "PREF40",
        "prefname": "福岡県",
        "areacode_s": "AREAS5434",
        "areaname_s": "柳川",
        "category_code_l": [
            "RSFST07000",
            ""
        ],
        "category_name_l": [
            "お好み焼き・粉物",
            ""
        ],
        "category_code_s": [
            "RSFST07002",
            ""
        ],
        "category_name_s": [
            "広島風お好み焼き",
            ""
        ]
    },
    "budget": 2000,
    "party": "",
    "lunch": 2000,
    "credit_card": "",
    "e_money": "",
    "flags": {
        "mobile_site": 1,
        "mobile_coupon": 0,
        "pc_coupon": 0
    }
}
"""
        let shop = try JSONDecoder().decode(Shop.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(shop.name, "今生焼 大川店")
        XCTAssertEqual(shop.nameKana, "コンジョウヤキ オオカワテン")
        XCTAssertEqual(shop.latitude, "33.202820")
        XCTAssertEqual(shop.longitude, "130.388015")
        XCTAssertEqual(shop.category, "鉄板×広島流お好み焼")
        XCTAssertEqual(shop.imageUrl.shopImage1, "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5c.jpg")
        XCTAssertEqual(shop.imageUrl.shopImage2, "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5d.jpg")
        XCTAssertEqual(shop.imageUrl.qrcode, "https://c-r.gnst.jp/tool/qr/?id=fap1004&q=6")
        XCTAssertEqual(shop.address, "〒831-0031 福岡県大川市大字上巻字野口430-1")
        XCTAssertEqual(shop.tel, "050-3464-8707")
        XCTAssertEqual(shop.opentime, "月～日 11:00～21:00")
        XCTAssertEqual(shop.pr.prShort, "【大川市上巻野口エリア】 ゆめタウン大川1F 広島のソウルフード“お好み焼”と鉄板料理を楽しめる『今生焼』")
        XCTAssertEqual(shop.code.genre.count, 2)
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
