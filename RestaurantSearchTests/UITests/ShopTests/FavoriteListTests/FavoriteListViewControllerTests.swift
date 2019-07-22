//
//  FavoriteListTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/07/03.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class FavoriteListViewControllerTests: XCTestCase {
    
    func testInstantiate() {
        let vc = FavoriteListViewController.instantiate()
        XCTAssertNotNil(vc)
    }
}
