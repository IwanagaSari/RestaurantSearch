//
//  ImageListCell.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/07.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import Foundation
import Alamofire

// swiftlint:disable private_outlet

final class ImageListCell: UICollectionViewCell {
    var onReuse: (() -> Void)?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var imageViewInShopInfo: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        onReuse?()
    }
}
