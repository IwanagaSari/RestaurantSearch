//
//  Area.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/03/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

/// エリア
struct Area: Codable {
    let areaCode: String
    let areaName: String
    
    enum CodingKeys: String, CodingKey {
        case areaCode = "area_code"
        case areaName = "area_name"
    }
    
    init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
              let areaDictionary = dictionary["area"] as? [String: Any],
              let areaCode = areaDictionary["area_code"] as? String,
              let areaName = areaDictionary["area_name"] as? String else {
                throw ResponseError.unexpectedObject(object)
        }
        self.areaCode = areaCode
        self.areaName = areaName
    }
}
