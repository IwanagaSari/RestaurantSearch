//
//  ShopListViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit
import Alamofire

final class ShopListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let apiOperater = APIOperater()
    private var shopList: [Shop] = []
    private let imageDownloader = ImageDownloader()
    @IBOutlet private var errorView: UIView!
    @IBOutlet weak private var errorTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShop()
        self.collectionView.backgroundView = errorView
    }
    
    private func getShop() {
        apiOperater.getShop(areacodeS: "AREAS5504", // とりあえず
            success: { [weak self] shopResponseBody in
                self?.showShopList(shopResponseBody)
            }, failure: { [weak self] error in
                self?.showError(error)
            }
        )
    }
    
    private func showShopList(_ shopResponseBody: ShopResponseBody) {
        self.shopList = shopResponseBody.shop
        self.collectionView.reloadData()
    }
    
    private func showError(_ error: Error) {
        errorTextView.text = error.localizedDescription
    }
    
    private func showShopInfo(_ shop: Shop) {
        let vc = ShopInfoViewController.instantiate(shop: shop)
        show(vc, sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopListCell", for: indexPath)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let imageURL = URL(string: shopList[indexPath.row].imageUrl.shopImage1)!
        
        imageDownloader.getImage(url: imageURL,
                                 success: {shopImage in
                                    imageView.image = shopImage
                                },
                                 failure: { [weak self] error in
                                    self?.showError(error)
                                }
        )
        let label = cell.contentView.viewWithTag(2) as! UILabel
        label.text = shopList[indexPath.row].name
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shop = shopList[indexPath.row]
        showShopInfo(shop)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
}
