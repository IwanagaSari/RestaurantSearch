//
//  ShopListTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/06/03.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class ShopListTests: XCTestCase {
    
    func testInstantiate() {
        let townCode = "AREAS5504"
        let freeword = "焼肉"
        let vc = ShopListViewController.instantiate(townCode: townCode, freeword: freeword)
        XCTAssertNotNil(vc)
    }
}
