//
//  ShopListViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class ShopListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let photos = ["2", "3"]
    let apiOperater = APIOperater()
    var shops: [Shop] = []
    
    override func viewDidLoad() {
        apiOperater.getShop(success: { shopResponseBody in
            self.shops = shopResponseBody.shop
            print(self.shops.count)
            print(self.shops[0].imageUrl.shopImage1)
            self.collectionView.reloadData()
        }, failure: { error in
            print(error)
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "ShopListCell",
                                               for: indexPath)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let shopimage = URL(string: shops[indexPath.row].imageUrl.shopImage1)!
        let imageData = try? Data(contentsOf: shopimage)
        //let cellImage = UIImage(named: photos[indexPath.row])
        imageView.image = UIImage(data: imageData!)
        
        let label = cell.contentView.viewWithTag(2) as! UILabel
        label.text = "店の名前"
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
}
