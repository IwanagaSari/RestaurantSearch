//
//  TownSelectTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永 彩里 on 2019/05/27.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class TownSelectTests: XCTestCase {
    private let dummyAPI = DummyAPI()
    
    func testInstantiate() {
        let city = City(cityCode: "666", cityName: "福岡市", pref: City.Pref(prefCode: "111",
                                                                            prefName: "福岡県"))
        let vc = TownSelectViewController.instantiate(city: city)
        XCTAssertNotNil(vc)
    }
    
    func testShowTownList() {
        let city = City(cityCode: "666", cityName: "福岡市", pref: City.Pref(prefCode: "111",
                                                                                prefName: "福岡県"))
        let vc = TownSelectViewController.instantiate(city: city)
        vc.apiOperater = dummyAPI
        vc.loadViewIfNeeded()
        
        let number = vc.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 1)
        
        let cell = vc.tableView.cellForRow(at: IndexPath(row: 0, section: 0))!
        XCTAssertEqual(cell.textLabel?.text, "桜坂・小笹")
    }
}
