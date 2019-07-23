//
//  SearchTopDetailViewControllerTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永 彩里 on 2019/07/22.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class SearchTopDetailViewControllerTests: XCTestCase {
    
    func testInstantiate() {
        let vc = SearchTopDetailViewController.instantiate()
        XCTAssertNotNil(vc)
    }
}
