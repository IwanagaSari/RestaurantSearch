//
//  AreaSearchAPI.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/03/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

struct Area: Codable {
    let areaCode: String
    let areaName: String
    
    enum CordingKeys: String, CodingKey {
        case areaCode = "area_code"
        case areaName = "area_name"
    }
}
