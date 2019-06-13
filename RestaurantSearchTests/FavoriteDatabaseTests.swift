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
    
    func testAddANDRemove() {
        database.add("shopID")
        XCTAssertEqual(database.all().contains("shopID"), true)
        XCTAssertEqual(database.all().count, 1)
        
        database.remove("shopID")
        XCTAssertEqual(database.all().contains("test"), false)
        XCTAssertEqual(database.all().count, 0)
    }
    
    override func tearDown() {
        super.tearDown()
        var shopIDList = database.all()
        shopIDList.removeAll()
        
    }
}
