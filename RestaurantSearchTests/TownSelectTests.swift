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
    
    func testInstantiate() {
        let city = City(cityCode: "222", cityName: "福岡市", pref: City.Pref(prefCode: "111",
                                                                            prefName: "福岡県"))
        let vc = TownSelectViewController.instantiate(city: city)
        XCTAssertNotNil(vc)
    }
}
