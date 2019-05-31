//
//  ImageDownloder.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/05/29.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import Foundation
import Alamofire

final class ImageDownloader {
    private let cache = NSCache<NSURL, UIImage>()
    static let shared = ImageDownloader()
    
    func getImage(url: URL, success: @escaping (UIImage) -> Void, failure: @escaping (Error) -> Void) {
        //キャッシュに保存されている場合
        if let imageFromCache = self.cache.object(forKey: url as NSURL) {
            success(imageFromCache)
        // キャッシュに保存されていないとする
        } else {
            Alamofire.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        success(image)
                        self.cache.setObject(image, forKey: url as NSURL)
                    }
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
}
