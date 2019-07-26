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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var lodingIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameLabel.text = nil
        errorMessageLabel.text = nil
        
        onReuse?()
    }
}
