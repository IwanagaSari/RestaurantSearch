//
//  City.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/03/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

/// 市
struct City: Codable {
    let areacodeL: String
    let areanameL: String
    let pref: Pref
    
    struct Pref: Codable {
        let prefCode: String
        let prefName: String
        
        enum CodingKeys: String, CodingKey {
            case prefCode = "pref_code"
            case prefName = "pref_name"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case areacodeL = "areacode_l"
        case areanameL = "areaname_l"
        case pref
    }
}
