//
//  ShopListViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class ShopListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let apiOperater: APIType = APIOperater()
    var shop: [Shop] = []
    let photos = ["2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShop()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shop.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "ShopListCell",
                                               for: indexPath)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let imageURL = URL(string: shop[indexPath.row].imageUrl.shopImage1)!
        
        fetchImage(url: imageURL, completion: { shopImage, error in
            if error != nil {
                print("error")
            } else {
                imageView.image = shopImage
            }
        })
        
        let label = cell.contentView.viewWithTag(2) as! UILabel
        label.text = shop[indexPath.row].name
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
    
    func getShop() {
        apiOperater.getShop(areacodeS: "AREAS5504", success: { shopResponseBody in
            self.showShop(shopResponseBody)
        }, failure: { error in
            
        })
    }
    
    func showShop(_ shopResponseBody: ShopResponseBody) {
        self.shop = shopResponseBody.shop
        self.collectionView.reloadData()
    }
    
    func fetchImage(url: URL, completion: @escaping ((UIImage?, Error?) -> Void)) -> URLSessionTask? {
        // キャッシュに保存されていないとする
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { completion(image, nil) }
                }
            } else {
                DispatchQueue.main.async { completion(nil, error) }
            }
        })
        task.resume()
        return task
    }
}
