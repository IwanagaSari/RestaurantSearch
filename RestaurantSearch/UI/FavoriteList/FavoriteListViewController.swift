//
//  FavoriteListViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

struct Favorite {
    let id: String
    var shop: Shop?
    var error: Error?
    var isImageDownloading: Bool = false
    
    var isShopLoading: Bool {
        return shop == nil && error == nil
    }
    
    var isLoading: Bool {
        return isImageDownloading || isShopLoading
    }
}

final class FavoriteListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet private var noneFavoritesBackgroundView: UIView!
    @IBOutlet weak private var noneFavoritesMessageLabel: UILabel!
    private var favorites: [Favorite] = [] {
        didSet { settingBackgroundView() }
    }
    private let apiOperater: APIType = APIOperater()
    private let imageDownloader = ImageDownloader.shared
    private let favoriteDatabase: FavoriteDatabaseType = FavoriteDatabase.shared
    
    static func instantiate() -> FavoriteListViewController {
        let vc = UIStoryboard(name: "FavoriteList", bundle: nil).instantiateInitialViewController() as! FavoriteListViewController
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateFavorites()
        getShopByIDList()
    }
    
    private func updateFavorites() {
        let favoriteIds = favoriteDatabase.all()
        favorites = favoriteIds.map { Favorite(id: $0, shop: nil, error: nil) }
        collectionView.reloadData()
    }
    
    private func settingBackgroundView() {
        collectionView.backgroundView = favorites.isEmpty ? noneFavoritesBackgroundView : nil
        noneFavoritesMessageLabel.text = favorites.isEmpty ? "お気に入りが登録されていません" : nil
    }
    
    private func getShopByIDList() {
        for favorite in favorites {
            apiOperater.getShopByID(shopID: favorite.id,
                                    success: { [weak self] shopResponseBody in
                                        self?.updateShopList(shopResponseBody)
                                    },
                                    failure: { [weak self] error in
                                        self?.updateShopError(error, shopID: favorite.id)
                                    })
        }
    }
    
    private func updateShopList(_ shopResponseBody: ShopResponseBody) {
        if let index = favorites.firstIndex(where: { $0.id == shopResponseBody.shop[0].id }) {
            favorites[index].shop = shopResponseBody.shop[0]
        }
        collectionView.reloadData()
    }
    
    private func updateShopError(_ error: Error, shopID: String) {
        if let index = favorites.firstIndex(where: { $0.id == shopID }) {
            favorites[index].error = error
        }
        collectionView.reloadData()
    }
    
    private func showShopInfo(_ shop: Shop) {
        let vc = ShopInfoViewController.instantiate(shop: shop)
        show(vc, sender: nil)
    }
    
    private func showDeleteAlert(shopID: String) {
        let alertController = UIAlertController(title: "お店情報が取得できません", message: "お気に入りから削除しますか？", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "YES", style: .default, handler: { [weak self] _ in
            self?.removeShop(shopID)
        })
        let action2 = UIAlertAction(title: "NO", style: .default, handler: nil)
        alertController.addAction(action1)
        alertController.addAction(action2)
        present(alertController, animated: true, completion: nil)
    }
    
    private func removeShop(_ shopID: String) {
        if let index = favorites.firstIndex(where: { $0.id == shopID }) {
            favorites.remove(at: index)
        }
        favoriteDatabase.remove(shopID)
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteListCell", for: indexPath) as! ImageListCell
        var favorite = favorites[indexPath.row]
        let shop = favorite.shop
        
        if favorite.isLoading {
            cell.loadingIndicator.startAnimating()
        } else {
            cell.loadingIndicator.stopAnimating()
        }
        
        // エラー表示
        if let error = favorite.error {
            cell.errorMessageLabel.text = error.localizedDescription
            cell.imageView.backgroundColor = UIColor.lightGray
            cell.loadingIndicator.stopAnimating()
        }
        
        // 店名の表示
        cell.nameLabel.text = shop?.name
        
        // 画像の表示
        if let url = URL(string: shop?.imageUrl.shopImage1 ?? "") {
            favorite.isImageDownloading = true
            let request = imageDownloader.getImage(url: url,
                                                   success: { shopImage in
                                                       cell.imageView.image = shopImage
                                                       favorite.isImageDownloading = false
                                                   },
                                                   failure: { [weak self] error in
                                                       self?.updateShopError(error, shopID: favorite.id)
                                                       favorite.isImageDownloading = false
                                                   })
            cell.onReuse = {
                request?.cancel()
            }
        } else {
            cell.imageView.image = nil
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        if let shop = favorite.shop {
            showShopInfo(shop)
        } else if favorite.error != nil {
            showDeleteAlert(shopID: favorite.id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
}
