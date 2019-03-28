//
//  Town.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/03/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

/// 町
struct Town: Codable {
    let areacodeS: String
    let areanameS: String
    let gareaLarge: AreaL

    struct AreaL: Codable {
        let areacodeL: String
        let areanameL: String

        enum CodingKeys: String, CodingKey {
            case areacodeL = "areacode_l"
            case areanameL = "areaname_l"
        }
    }

    enum CodingKeys: String, CodingKey {
        case areacodeS = "areacode_s"
        case areanameS = "areaname_s"
        case gareaLarge = "garea_large"
    }
}
