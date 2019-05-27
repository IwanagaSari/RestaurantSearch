//
//  CitySelectTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永 彩里 on 2019/05/27.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

class CitySelectTests: XCTestCase {
    
    func testInitialize() {
        let prefecture = Prefecture(prefCode: "111", prefName: "福岡県", areaCode: "000")
        let vc: CitySelectViewController!
        vc = CitySelectViewController.instantiate(prefecture: prefecture)
        XCTAssertNotNil(vc)
    }
}
