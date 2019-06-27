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
    
    // swiftlint:disable function_body_length
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
    "image_url": {
        "shop_image1": "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5c.jpg",
        "shop_image2": "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5d.jpg",
        "qrcode": "https://c-r.gnst.jp/tool/qr/?id=fap1004&q=6"
    },
    "address": "〒831-0031 福岡県大川市大字上巻字野口430-1",
    "tel": "050-3464-8707",
    "opentime": "月～日 11:00～21:00",
    "holiday": "不定休日あり\n※※ゆめタウン大川に準ずる",
    "parking_lots": "",
    "pr": {
        "pr_short": "【大川市上巻野口エリア】 ゆめタウン大川1F 広島のソウルフード“お好み焼”と鉄板料理を楽しめる『今生焼』",
        "pr_long": "広島出身のオーナーが「広島の味をもっと知ってほしい」との想いでオープンした当店。\n広島県民に愛され続けるお好み焼をはじめ、呉名物のがんす、肉厚な牡蠣など\n福岡にいながら広島を存分に味わえるメニューを揃えました。"
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
}
"""
        let shop = try JSONDecoder().decode(Shop.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(shop.id, "fap1004")
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
        XCTAssertEqual(shop.holiday, "不定休日あり\n※※ゆめタウン大川に準ずる")
        XCTAssertEqual(shop.pr.prShort, "【大川市上巻野口エリア】 ゆめタウン大川1F 広島のソウルフード“お好み焼”と鉄板料理を楽しめる『今生焼』")
        XCTAssertEqual(shop.pr.prLong, "広島出身のオーナーが「広島の味をもっと知ってほしい」との想いでオープンした当店。\n広島県民に愛され続けるお好み焼をはじめ、呉名物のがんす、肉厚な牡蠣など\n福岡にいながら広島を存分に味わえるメニューを揃えました。")
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
            "id": "fap1004",
            "update_date": "2019-04-02T02:33:06+09:00",
            "name": "今生焼 大川店",
            "name_kana": "コンジョウヤキ オオカワテン",
            "latitude": "33.202820",
            "longitude": "130.388015",
            "category": "鉄板×広島流お好み焼",
            "image_url": {
                "shop_image1": "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5c.jpg",
                "shop_image2": "https://uds.gnst.jp/rest/img/a9b68a5k0000/t_0n5d.jpg",
                "qrcode": "https://c-r.gnst.jp/tool/qr/?id=fap1004&q=6"
            },
            "address": "〒831-0031 福岡県大川市大字上巻字野口430-1",
            "tel": "050-3464-8707",
            "opentime": "月～日 11:00～21:00",
            "parking_lots": "",
            "pr": {
                "pr_short": "【大川市上巻野口エリア】 ゆめタウン大川1F 広島のソウルフード“お好み焼”と鉄板料理を楽しめる『今生焼』"
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
            }
        }
    ]
}
"""
        let body = try JSONDecoder().decode(ShopResponseBody.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(body.shop.count, 1)
    }
}
