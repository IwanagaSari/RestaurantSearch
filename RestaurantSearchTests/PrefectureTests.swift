//
//  PrefectureTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/03/26.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class PrefectureTests: XCTestCase {
    
    func testDecode() throws {
        let json = """
{
    "@attributes": {
        "api_version": "v3"
    },
    "pref": [
        {
            "pref_code": "PREF01",
            "pref_name": "北海道",
            "area_code": "AREA150"
        }
    ]
}
"""
        let body = try JSONDecoder().decode(PrefectureResponseBody.self, from: json.data(using: .utf8)!)
        let pref = body.pref[0]
        XCTAssertEqual(pref.prefCode, "PREF01")
        XCTAssertEqual(pref.prefName, "北海道")
        XCTAssertEqual(pref.areaCode, "AREA150")
    }
}
