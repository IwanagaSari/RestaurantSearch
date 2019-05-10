//
//  APIOperaterTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永 彩里 on 2019/05/09.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class APIOperaterTests: XCTestCase {
    let apiOperater = APIOperater()
    
    func testGetAreaAPI() {
        let expect = self.expectation(description: #function)
        apiOperater.getAreaAPI(success: { areaResponseBody in
            XCTAssertEqual("北海道", areaResponseBody.area[0].areaName)
            expect.fulfill()
        }, failure: { error in
            XCTFail("\(error)")
        })
        
        wait(for: [expect], timeout: 5)
    }
    
    func testGetPrefectureAPI() {
        let expect = self.expectation(description: #function)
        apiOperater.getPrefectureAPI(success: { prefectureResponseBody in
            XCTAssertEqual(prefectureResponseBody.pref[0].prefName, "北海道")
            expect.fulfill()
        }, failure: { error in
            XCTFail("\(error)")
        })
        
        wait(for: [expect], timeout: 5)
    }
    
    func testGetCityAPI() {
        let expect = self.expectation(description: #function)
        apiOperater.getCityAPI(success: { cityResponseBody in
            XCTAssertEqual(cityResponseBody.gareaLarge[0].areanameL, "札幌駅・大通・すすきの")
            expect.fulfill()
        }, failure: { error in
            XCTFail("\(error)")
        })
        
        wait(for: [expect], timeout: 5)
    }
    
    func testGetTownAPI() {
        let expect = self.expectation(description: #function)
        apiOperater.getTownAPI(success: { townResponseBody in
            XCTAssertEqual(townResponseBody.gareaSmall[0].areanameS, "札幌駅")
            expect.fulfill()
        }, failure: { error in
            XCTFail("\(error)")
        })
        
        wait(for: [expect], timeout: 5)
    }
}
