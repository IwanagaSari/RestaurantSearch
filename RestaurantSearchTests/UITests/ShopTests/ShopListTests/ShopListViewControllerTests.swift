//
//  ShopListTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/06/03.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class ShopListViewControllerTests: XCTestCase {
    private let dummyAPI = DummyAPI()
    
    func testInstantiate() {
        let townCode = "AREAS5504"
        let freeword = "焼肉"
        let vc = ShopListViewController.instantiate(townCode: townCode, freeword: freeword)
        XCTAssertNotNil(vc)
    }
    
    func testCell() {
        let vc = ShopListViewController.instantiate(townCode: "test", freeword: "test")
        vc.apiOperater = dummyAPI
        vc.loadViewIfNeeded()
            
        let number = vc.collectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(number, 1)
        
        let cell = vc.collectionView(vc.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! ImageListCell
        XCTAssertEqual(cell.nameLabel.text, "店の名前")
        
        var called = false
        cell.onReuse = { called = true }
        
        cell.prepareForReuse()
        XCTAssertTrue(called)
        XCTAssertNil(cell.imageView.image)
        XCTAssertNil(cell.errorMessageLabel.text)
    }
}
