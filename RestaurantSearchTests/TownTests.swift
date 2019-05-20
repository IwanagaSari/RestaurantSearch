//
//  TownTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/03/28.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class TownTests: XCTestCase {
    
    func testTownDecode() throws {
        let json = """
{
    "areacode_s": "AREAS5502",
    "areaname_s": "札幌駅",
    "garea_middle": {
        "areacode_m": "AREAM5502",
        "areaname_m": "札幌駅"
    },
    "garea_large": {
        "areacode_l": "AREAL5500",
        "areaname_l": "札幌駅・大通・すすきの"
    },
    "pref": {
        "pref_code": "PREF01",
        "pref_name": "北海道"
    }
}
"""
        let town = try JSONDecoder().decode(Town.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(town.townCode, "AREAS5502")
        XCTAssertEqual(town.townName, "札幌駅")
        XCTAssertEqual(town.city.areacodeL, "AREAL5500")
        XCTAssertEqual(town.city.areanameL, "札幌駅・大通・すすきの")
    }
    
    func testTownResponseBodyDecode() throws {
        let json = """
{
    "@attributes": {
        "api_version": "v3"
    },
    "garea_small": [
        {
            "areacode_s": "AREAS5502",
            "areaname_s": "札幌駅",
            "garea_middle": {
                "areacode_m": "AREAM5502",
                "areaname_m": "札幌駅"
            },
            "garea_large": {
                "areacode_l": "AREAL5500",
                "areaname_l": "札幌駅・大通・すすきの"
            },
            "pref": {
                "pref_code": "PREF01",
                "pref_name": "北海道"
            }
        }
    ]
}
"""
        let body = try JSONDecoder().decode(TownResponseBody.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(body.town.count, 1)
    }
}
