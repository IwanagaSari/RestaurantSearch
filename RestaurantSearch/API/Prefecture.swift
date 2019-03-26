//
//  Prefecture.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/03/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

/// 都道府県
struct Prefecture: Codable {
    let prefCode: String
    let prefName: String
    let areaCode: String
    
    enum CodingKeys: String, CodingKey {
        case prefCode = "pref_code"
        case prefName = "pref_name"
        case areaCode = "area_code"
    }
}
