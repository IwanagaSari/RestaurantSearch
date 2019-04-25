//
//  ShopInfoViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit
import SafariServices

final class ShopInfoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopAdressLabel: UILabel!
    @IBOutlet weak var shopTopImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let shopImages = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // お店のTopImageViewの設定
        shopTopImageView.image = UIImage(named: "1")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopInfoCell", for: indexPath)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let cellImage = UIImage(named: shopImages[indexPath.row])
        imageView.image = cellImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
    
    /// 追加するボタンをタップされた時
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        //お気に入りに入っていないお店であれば、追加ボタンを表示する
    }
    
    /// 削除ボタンをタップされた時
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        //お気に入りにすでに入っているお店なら、削除ボタンを表示する
    }
    
    /// 電話をかけるボタンをタップされた時
    @IBAction func telephoneButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "telprompt://0926426900")!, completionHandler: nil)
        print("電話をかける")
    }
    
    /// さらに詳しくボタンをタップされた時
    @IBAction func detailButtonTapped(_ sender: UIButton) {
        // 仮に「一蘭」というお店だとする
        let searchName: String = "一蘭"
        var components = URLComponents(string: "https://www.google.co.jp/search")!
        components.queryItems = [URLQueryItem(name: "q", value: searchName)]
        if let url = components.url {
            let safari = SFSafariViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
    }
}
