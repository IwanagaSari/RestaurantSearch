//
//  Shop.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/05/15.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

struct ShopResponseBody: Codable {
    let rest: [Shop]
}

struct Shop: Codable {
    let name: String
    let tel: String
    let address: String
    let imageUrl: Image
    
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
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
        case tel
        case address
    }
}
