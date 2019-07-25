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
    
    func testDecodeAPIError() throws {
        let json = """
{
        "code": 401,
        "message": "無効なkeyidです"
}
"""
        let apiError = try JSONDecoder().decode(APIError.self, from: Data(json.utf8))
        XCTAssertEqual(apiError.message, "無効なkeyidです")
    }
    
    func testErrorFromDataWithErrorArray() throws {
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
        let apiError = try errorFromData(Data(json.utf8))
        XCTAssertEqual(apiError.message, "無効なkeyidです")
    }
    
    func testErrorFromDataWithErrorObject() throws {
        let json = """
{
    "@attributes": {
        "api_version": "v3"
    },
    "error":
        {
            "code": 401,
            "message": "無効なkeyidです"
        }
}
"""
        let apiError = try errorFromData(Data(json.utf8))
        XCTAssertEqual(apiError.message, "無効なkeyidです")
    }
}
