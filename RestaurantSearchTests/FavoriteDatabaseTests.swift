//
//  FavoriteDatabaseTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/06/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class FavoriteDatabaseTests: XCTestCase {

    func testSettingShopIDList() {
        let database = FavoriteDatabase(defaults: UserDefaults.standard)
        database.shopIDList = ["testID"]
        XCTAssertEqual(database.shopIDList, ["testID"])
    }
    
    func testSettingShopIDListForTestonly() {
        let database = FavoriteDatabase(defaults: UserDefaults(suiteName: "TestOnly")!)
        XCTAssertEqual(database.shopIDList.count, 0)
    }
}
