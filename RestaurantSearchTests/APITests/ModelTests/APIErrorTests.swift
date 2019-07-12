//
//  APIErrorTests.swift
//  RestaurantSearchTests
//
//  Created by 岩永 彩里 on 2019/06/27.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import RestaurantSearch

final class APIErrorTests: XCTestCase {
    
    func testAPIErrorDecode() throws {
        let json = """
{
        "code": 401,
        "message": "無効なkeyidです"
}
"""
        let apiError2 = try JSONDecoder().decode(APIError.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(apiError2.message, "無効なkeyidです")
    }
    
    func testAPIErrorResponseBodyDecode() throws {
        let json = """
{
    "@attributes":{
        "api_version":"v3"
    },
    "error":{
        "code":"400",
        "message":"指定されたパラメーターは存在しません"
    }
}
"""
        let body = try JSONDecoder().decode(APIErrorResponseBody.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(body.error.message, "指定されたパラメーターは存在しません")
    }
    
    func testAPIErrorResponseBody2Decode() throws {
        let json = """
{
    "@attributes": {
        "api_version": "v3"
    },
    "error": [
        {
            "code": 401,
            "message": "無効なkeyidです"
        }
    ]
}
"""
        let body = try JSONDecoder().decode(APIErrorResponseBody2.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(body.error.count, 1)
    }
}
