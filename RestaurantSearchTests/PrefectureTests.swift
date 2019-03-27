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
    
    func testMappingArea() throws {
        let json = """
  {
    "pref_code": "PREF01",
    "pref_name": "北海道",
    "area_code": "AREA150"
  }
"""
        let pref = try JSONDecoder().decode(Prefecture.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(pref.prefCode, "PREF01")
        XCTAssertEqual(pref.prefName, "北海道")
        XCTAssertEqual(pref.areaCode, "AREA150")
    }
}
