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
    private var database: FavoriteDatabase!
    
    override func setUp() {
        super.setUp()
        
        database = FavoriteDatabase(defaults: UserDefaults(suiteName: UUID().uuidString)!)
    }
    
    func testNoSettingShopIDList() {
        XCTAssertEqual(database.shopIDList.count, 0)
    }

    func testSettingShopIDList() {
        database.shopIDList = ["testID"]
        XCTAssertEqual(database.shopIDList, ["testID"])
    }
    
    override func tearDown() {
        database.shopIDList.removeAll()
    }
}
