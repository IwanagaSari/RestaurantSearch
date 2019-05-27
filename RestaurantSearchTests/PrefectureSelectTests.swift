//
//  PrefectureSelectTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/05/27.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class PrefectureSelectTests: XCTestCase {
    
    func testInitialize() {
        let area = Area(areaCode: "000", areaName: "九州")
        let vc: PrefectureSelectViewController!
        vc = PrefectureSelectViewController.instantiate(area: area)
        XCTAssertNotNil(vc)
    }
}
