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
        
        enum Codingkeys: String, CodingKey {
            case areacodeL = "areacode_l"
            case areanameL = "areaname_l"
        }
    }
        
    enum Codingkeys: String, CodingKey {
        case gareaLarge = "garea_large"
        case areacodeS = "areacode_s"
        case areanameS = "areaname_s"
    }
}
