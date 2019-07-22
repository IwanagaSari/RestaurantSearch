//
//  AreaSelectViewControllerTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永 彩里 on 2019/07/22.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class AreaSelectViewControllerTests: XCTestCase {
    private let dummyAPI = DummyAPI()
    
    func testInstantiate() {
        let vc = AreaSelectViewController.instantiate()
        XCTAssertNotNil(vc)
    }
    
    func testShowAreaList() {
        let vc = AreaSelectViewController.instantiate()
        vc.apiOperater = dummyAPI
        vc.loadViewIfNeeded()
        
        let number = vc.tableView(vc.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(number, 1)
        
        let cell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "九州")
    }
}
