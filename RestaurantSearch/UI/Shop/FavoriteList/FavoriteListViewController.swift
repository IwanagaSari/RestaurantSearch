//
//  FavoriteListViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class FavoriteListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let defaults = UserDefaults.standard
    private var imageList: [String] = []
    private var shopList: [Shop] = []
    private let apiOperater: APIType = APIOperater()
    private let imageDownloader = ImageDownloader.shared
    @IBOutlet private var errorView: UIView!
    @IBOutlet weak private var errorTextView: UITextView!
    
    static func instantiate() -> FavoriteListViewController {
        let vc = UIStoryboard(name: "FavoriteList", bundle: nil).instantiateInitialViewController() as! FavoriteListViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShopByIDList()
        collectionView.backgroundView = errorView
    }
    
    private func getShopByIDList() {
        for id in FavoriteDatabase(defaults: self.defaults).shopIDList {
            apiOperater.getShopByID(shopID: id,
                                    success: { [weak self] shopResponseBody in
                                        self?.showShopList(shopResponseBody)
                                    },
                                    failure: { [weak self] error in
                                        self?.showError(error)
                                    })
        }
    }
    
    private func showShopList(_ shopResponseBody: ShopResponseBody) {
        shopList.append(shopResponseBody.shop[0])
        imageList.append(shopResponseBody.shop[0].imageUrl.shopImage1)
        collectionView.reloadData()
    }
    
    private func showError(_ error: Error) {
        errorTextView.text = error.localizedDescription
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteListCell", for: indexPath)
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let imageURL = URL(string: shopList[indexPath.row].imageUrl.shopImage1)!
        
        imageDownloader.getImage(url: imageURL,
                                 success: {shopImage in
                                    imageView.image = shopImage
                                },
                                 failure: { [weak self] error in
                                    self?.showError(error)
                                })
        
        let label = cell.contentView.viewWithTag(2) as! UILabel
        label.text = shopList[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
}
