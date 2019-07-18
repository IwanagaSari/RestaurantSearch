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
    private let dummyAPI = DummyAPI()
    
    func testInstantiate() {
        let townCode = "AREAS5504"
        let freeword = "焼肉"
        let vc = ShopListViewController.instantiate(townCode: townCode, freeword: freeword)
        XCTAssertNotNil(vc)
    }
    
    func testCellCount() {
        let vc = ShopListViewController.instantiate(townCode: "test", freeword: "test")
        vc.apiOperater = dummyAPI
        vc.loadViewIfNeeded()
            
        let cell = vc.collectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(cell, 1)
    }
}
