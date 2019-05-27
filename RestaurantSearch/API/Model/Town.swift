//
//  Town.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/03/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

struct TownResponseBody: Codable {
    let townList: [Town]
    
    enum CodingKeys: String, CodingKey {
        case townList = "garea_small"
    }
}

/// 町
struct Town: Codable {
    let townCode: String
    let townName: String
    let city: AreaL

    struct AreaL: Codable {
        let cityCode: String
        let cityName: String

        enum CodingKeys: String, CodingKey {
            case cityCode = "areacode_l"
            case cityName = "areaname_l"
        }
    }

    enum CodingKeys: String, CodingKey {
        case townCode = "areacode_s"
        case townName = "areaname_s"
        case city = "garea_large"
    }
}
