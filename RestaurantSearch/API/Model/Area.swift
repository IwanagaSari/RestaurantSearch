//
//  Area.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/03/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

struct AreaResponseBody: Codable {
    let areaList: [Area]
    
    enum CodingKeys: String, CodingKey {
        case areaList = "area"
    }
}

/// エリア
struct Area: Codable {
    let areaCode: String
    let areaName: String
    
    enum CodingKeys: String, CodingKey {
        case areaCode = "area_code"
        case areaName = "area_name"
    }
}
