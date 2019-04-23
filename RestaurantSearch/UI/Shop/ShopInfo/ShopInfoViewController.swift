//
//  ShopInfoViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit
import SafariServices

final class ShopInfoViewController: UIViewController,UICollectionViewDataSource,
UICollectionViewDelegate {
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopAdressLabel: UILabel!
    @IBOutlet weak var shopTopImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let shopImages = ["1", "2", "3"]
    
    override func viewDidLoad() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:self.view.frame.width/2 - 1, height: self.view.frame.width/2 - 1)
        layout.minimumInteritemSpacing = 2
        collectionView.collectionViewLayout = layout
        
        // お店のTopImageViewの設定
        shopTopImageView.image = UIImage(named: "1")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    let testCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "ShopImageCell",
                                               for: indexPath)
    let imageView = testCell.contentView.viewWithTag(1) as! UIImageView
    let cellImage = UIImage(named: shopImages[indexPath.row])
    imageView.image = cellImage
        
    return testCell
    }
    /// 電話をかけるボタンをタップされた時
    @IBAction func telephoneButtonTapped(_ sender: UIButton) {
    }
    
    /// さらに詳しくボタンをタップされた時
    @IBAction func safariButton(_ sender: UIButton) {
        // 仮に「一蘭」というお店だとする
        var searchName :String = "一蘭"
        var testURL = "https://www.google.co.jp/search?q=\(searchName)"
        testURL = testURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        if let url = URL(string: testURL) {
            let safari = SFSafariViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
    }
    
}
