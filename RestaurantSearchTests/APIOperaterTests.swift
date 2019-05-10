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
        apiOperater.getAreaAPI(success: { areaResponseBody in
            XCTAssertEqual("北海道", areaResponseBody.area[0].areaName)
        }, failure: { error in

        })
    }
    
    func testGetPrefectureAPI() {
        apiOperater.getPrefectureAPI(success: { prefectureResponseBody in
            XCTAssertEqual(prefectureResponseBody.pref[0].prefName, "北海道")
        }, failure: { error in
            
        })
    }
    
    func testGetCityAPI() {
        apiOperater.getCityAPI(success: { cityResponseBody in
            XCTAssertEqual(cityResponseBody.gareaLarge[0].areanameL, "札幌駅・大通・すすきの")
        }, failure: { error in
            
        })
    }
    
    func testGetTownAPI() {
        apiOperater.getTownAPI(success: { townResponseBody in
            XCTAssertEqual(townResponseBody.gareaSmall[0].areanameS, "札幌駅")
        }, failure: { error in
            
        })
    }
}
