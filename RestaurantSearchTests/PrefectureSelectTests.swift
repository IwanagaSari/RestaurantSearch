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
    private let dummyAPI = DummyAPI()
    
    func testInstantiate() {
        let area = Area(areaCode: "000", areaName: "九州")
        let vc = PrefectureSelectViewController.instantiate(area: area)
        XCTAssertNotNil(vc)
    }
    
    func testShowPrefectureList() {
        let area = Area(areaCode: "222", areaName: "九州")
        let vc = PrefectureSelectViewController.instantiate(area: area)
        vc.apiOperater = dummyAPI
        vc.loadViewIfNeeded()
        
        let number = vc.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 1)
        
        let cell = vc.tableView.cellForRow(at: IndexPath(row: 0, section: 0))!
        XCTAssertEqual(cell.textLabel?.text, "大濠・六本松・桜坂")
    }
}
