//
//  FavoriteListViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class FavoriteListViewController: UICollectionViewController {
    
    let shopImages = ["1", "2", "3"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteListCell", for: indexPath)
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let cellImage = UIImage(named: shopImages[indexPath.row])
        imageView.image = cellImage
        
        let label = cell.contentView.viewWithTag(2) as! UILabel
        label.text = "店の名前"
        
        return cell
    }
}

extension FavoriteListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width)
        
        return layout.itemSize
    }
}
