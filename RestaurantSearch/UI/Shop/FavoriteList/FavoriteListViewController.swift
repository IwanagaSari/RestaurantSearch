//
//  FavoriteListViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class FavoriteListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var shopList: [Shop] = []
    private let apiOperater: APIType = APIOperater()
    private let imageDownloader = ImageDownloader.shared
    private let favoriteDatabase: FavoriteDatabaseType = FavoriteDatabase.shared
    @IBOutlet private var errorView: UIView!
    @IBOutlet weak private var errorMessageLabel: UILabel!
    
    static func instantiate() -> FavoriteListViewController {
        let vc = UIStoryboard(name: "FavoriteList", bundle: nil).instantiateInitialViewController() as! FavoriteListViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShopByIDList()
    }
    
    private func getShopByIDList() {
        for id in favoriteDatabase.all() {
            apiOperater.getShopByID(shopID: id,
                                    success: { [weak self] shopResponseBody in
                                        self?.updateShopList(shopResponseBody)
                                    },
                                    failure: { [weak self] error in
                                        self?.showError(error)
                                    })
        }
    }
    
    private func updateShopList(_ shopResponseBody: ShopResponseBody) {
        shopList.append(shopResponseBody.shop[0])
        collectionView.backgroundView = nil
        collectionView.reloadData()
    }
    
    private func showError(_ error: Error) {
        errorMessageLabel.text = error.localizedDescription
        collectionView.backgroundView = errorView
    }
    
    private func showShopInfo(_ shop: Shop) {
        let vc = ShopInfoTableViewController.instantiate(shop: shop)
        show(vc, sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteListCell", for: indexPath) as! ImageListCell
        let shopImage = shopList[indexPath.row].imageUrl.shopImage1
        
        if shopImage.isEmpty {
            cell.imageViewInFavoliteList.image = UIImage(named: "error")
        } else {
            let imageURL = URL(string: shopImage)!
            let request = imageDownloader.getImage(url: imageURL,
                                                   success: { shopImage in
                                                        cell.imageViewInFavoliteList.image = shopImage
                                                   },
                                                   failure: { [weak self] error in
                                                        self?.showError(error)
                                                   })
            cell.onReuse = {
                request?.cancel()
            }
        }

        cell.shopNameInfavoriteList.text = shopList[indexPath.row].name
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shop = shopList[indexPath.row]
        showShopInfo(shop)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
}
