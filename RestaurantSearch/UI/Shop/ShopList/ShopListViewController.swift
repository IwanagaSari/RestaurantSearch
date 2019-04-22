//
//  ShopListViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class ShopListViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let photos = ["2", "3"]

    override func viewDidLoad() {
        
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:self.view.frame.width/2 - 5, height: self.view.frame.width/2 - 5)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let testCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                               for: indexPath)
        let imageView = testCell.contentView.viewWithTag(1) as! UIImageView
        let cellImage = UIImage(named: photos[indexPath.row])
        imageView.image = cellImage
        
        let label = testCell.contentView.viewWithTag(2) as! UILabel
        label.text = "店の名前"
        
        return testCell
    }
    
}
