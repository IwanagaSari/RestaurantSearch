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
}

final class FavoriteListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var favorites: [Favorite] = []
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
        
        updateFavorites()
        getShopByIDList()
    }
    
    private func updateFavorites() {
        favorites = favoriteDatabase.all().map { Favorite(id: $0, shop: Shop(id: $0,
                                                                             name: "",
                                                                             nameKana: "",
                                                                             latitude: "",
                                                                             longitude: "",
                                                                             category: "",
                                                                             imageUrl: Shop.Image(shopImage1: "", shopImage2: "", qrcode: ""),
                                                                             address: "",
                                                                             tel: "",
                                                                             opentime: "",
                                                                             pr: Shop.Pr(prShort: ""),
                                                                             code: Shop.Code(genre: [])))}
        collectionView.reloadData()
    }
    
    private func getShopByIDList() {
        for favorite in favorites {
            apiOperater.getShopByID(shopID: favorite.id,
                                    success: { [weak self] shopResponseBody in
                                        self?.updateShopList(shopResponseBody)
                                    },
                                    failure: { [weak self] error in
                                        self?.showError(error)
                                    })
        }
    }
    
    private func updateShopList(_ shopResponseBody: ShopResponseBody) {
        if let index = favorites.firstIndex(where: { $0.id == shopResponseBody.shop[0].id }) {
            favorites[index].shop = shopResponseBody.shop[0]
        }
        collectionView.backgroundView = nil
        collectionView.reloadData()
    }
    
    private func showError(_ error: Error) {
        errorMessageLabel.text = error.localizedDescription
        collectionView.backgroundView = errorView
    }
    
    private func showShopInfo(_ shop: Shop) {
        let vc = ShopInfoViewController.instantiate(shop: shop)
        show(vc, sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteListCell", for: indexPath) as! ImageListCell
        
        // 店名の表示
        if let name = favorites[indexPath.row].shop?.name {
            cell.shopNameInfavoriteList.text = name
        } else {
            cell.shopNameInfavoriteList.text = ""
        }
        
        // 画像の表示
        if let image = favorites[indexPath.row].shop?.imageUrl.shopImage1 {
            let imageURL = URL(string: image)!
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
        } else {
            // indicatorを表示させるかerror画像を表示させる
            cell.imageViewInFavoliteList.image = UIImage(named: "error")
        }

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // ここも変更する
        let shop = shopList[indexPath.row]
        showShopInfo(shop)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
}
