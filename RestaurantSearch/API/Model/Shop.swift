//
//  Shop.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/05/15.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

struct ShopResponseBody: Codable {
    let shop: [Shop]
    
    enum CodingKeys: String, CodingKey {
        case shop = "rest"
    }
}

struct Shop: Codable {
    let id: String
    let name: String
    let nameKana: String
    let latitude: String
    let longitude: String
    let category: String
    let imageUrl: Image
    let address: String
    let tel: String
    let opentime: String
    let holiday: String
    let pr: Pr
    let code: Code
    let budget: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nameKana = "name_kana"
        case latitude
        case longitude
        case category
        case imageUrl = "image_url"
        case address
        case tel
        case opentime
        case holiday
        case pr
        case code
        case budget
    }
    
    struct Image: Codable {
        let shopImage1: String
        let shopImage2: String
        let qrcode: String
        
        enum CodingKeys: String, CodingKey {
            case shopImage1 = "shop_image1"
            case shopImage2 = "shop_image2"
            case qrcode
        }
    }
    
    struct Pr: Codable {
        let prShort: String
        let prLong: String
        
        enum CodingKeys: String, CodingKey {
            case prShort = "pr_short"
            case prLong = "pr_long"
        }
    }
    
    struct Code: Codable {
        let genre: [String]
        
        enum CodingKeys: String, CodingKey {
            case genre = "category_name_s"
        }
    }
}
