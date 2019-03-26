//
//  GAreaLargeSearchAPITests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/03/26.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

class GAreaLargeSearchAPITests: XCTestCase {
    
    func testMappingArea() throws {
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
    }

}
