//
//  ImageListCell.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/07.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable private_outlet

final class ImageListCell: UICollectionViewCell {
    var onReuse: (() -> Void)?
    @IBOutlet weak var imageViewInShopList: UIImageView!
    @IBOutlet weak var shopNameInShopList: UILabel!
    @IBOutlet weak var imageViewInFavoliteList: UIImageView!
    @IBOutlet weak var shopNameInfavoriteList: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        onReuse?()
    }
}
