//
//  CitySelectTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永 彩里 on 2019/05/27.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class CitySelectTests: XCTestCase {
    private let dummyAPI = DummyAPI()
    
    func testInstantiate() {
        let prefecture = Prefecture(prefCode: "111", prefName: "福岡県", areaCode: "000")
        let vc = CitySelectViewController.instantiate(prefecture: prefecture)
        XCTAssertNotNil(vc)
    }
    
    func testShowCityList() {
        let prefecture = Prefecture(prefCode: "111", prefName: "福岡県", areaCode: "000")
        let vc = CitySelectViewController.instantiate(prefecture: prefecture)
        vc.apiOperater = dummyAPI
        vc.loadViewIfNeeded()
        
        let number = vc.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 1)
        
        let cell = vc.tableView.cellForRow(at: IndexPath(row: 0, section: 0))!
        XCTAssertEqual(cell.textLabel?.text, "大濠・六本松・桜坂")
    }
}
