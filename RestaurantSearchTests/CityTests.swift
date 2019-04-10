//
//  CityTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/03/26.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class CityTests: XCTestCase {
    
    func testCityDecode() throws {
        let json = """
{
    "areacode_l": "AREAL5500",
    "areaname_l": "札幌駅・大通・すすきの",
    "pref": {
        "pref_code": "PREF01",
        "pref_name": "北海道"
    }
}
"""
        let city = try JSONDecoder().decode(City.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(city.areacodeL, "AREAL5500")
        XCTAssertEqual(city.areanameL, "札幌駅・大通・すすきの")
        XCTAssertEqual(city.pref.prefCode, "PREF01")
        XCTAssertEqual(city.pref.prefName, "北海道")
    }
    
    func testCityResponseBodyDecode() throws {
        let json = """
{
    "@attributes": {
        "api_version": "v3"
    },
    "garea_large": [
        {
            "areacode_l": "AREAL5500",
            "areaname_l": "札幌駅・大通・すすきの",
            "pref": {
                "pref_code": "PREF01",
                "pref_name": "北海道"
            }
        }
    ]
}
"""
        let body = try JSONDecoder().decode(CityResponseBody.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(body.gareaLarge.count, 1)
    }    
}
