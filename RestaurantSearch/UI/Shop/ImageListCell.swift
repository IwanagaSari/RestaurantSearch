//
//  ImageListCell.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/07.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import Foundation
import Alamofire

class ImageListCell: UICollectionViewCell {
    var request: DataRequest?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        request?.cancel()
    }
}
