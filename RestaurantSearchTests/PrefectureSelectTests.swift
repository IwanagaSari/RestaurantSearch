//
//  PrefectureSelectTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永彩里 on 2019/05/27.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

class PrefectureSelectTests: XCTestCase {
    var  vc:  PrefectureSelectViewController!
    
    override func setUp() {
        super.setUp()
        
        vc = UIStoryboard(name: "PrefectureSelect", bundle: nil).instantiateViewController(withIdentifier: " PrefectureSelect") as? PrefectureSelectViewController
        XCTAssertNotNil(vc)
    }
}
