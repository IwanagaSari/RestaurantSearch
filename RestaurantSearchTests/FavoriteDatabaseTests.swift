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
    private let uuid = UUID().uuidString
    private lazy var defaults = UserDefaults(suiteName: self.uuid)!
    
    override func setUp() {
        super.setUp()
        
        database = FavoriteDatabase(defaults: defaults)
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.defaults.removeSuite(named: uuid)
    }
    
    func testAddANDRemove() {
        XCTAssertTrue(database.all().isEmpty)
        
        database.add("shopID")
        XCTAssertTrue(database.all().contains("shopID"))
        XCTAssertEqual(database.all().count, 1)
        
        database.remove("shopID")
        XCTAssertFalse(database.all().contains("shopID"))
        XCTAssertTrue(database.all().isEmpty)
    }
}
