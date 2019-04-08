//
//  AreaTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/03/26.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class AreaTests: XCTestCase {
    
    func testAreaDecode() throws {
        let json = """
{
    "area_code": "AREA150",
    "area_name": "北海道"
}
"""
        let area = try JSONDecoder().decode(Area.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(area.areaCode, "AREA150")
        XCTAssertEqual(area.areaName, "北海道")
    }
    
    func testAreaResponseBodyDecode() throws {
        let json = """
{
    "@attributes": {
        "api_version": "v3"
    },
    "area": [
        {
            "area_code": "AREA150",
            "area_name": "北海道"
        }
    ]
}
"""
        let body = try JSONDecoder().decode(AreaResponseBody.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(body.area.count, 1)
    }
}
