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

final class FavoriteListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ShopInfoViewControllerDelegate, UITabBarControllerDelegate {
    private var favorites: [Favorite] = []
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
        
        tabBarController?.delegate = self
        updateFavorites()
        getShopByIDList()
    }
    
    private func updateFavorites() {
        favorites = favoriteDatabase.all().map { Favorite(id: $0, shop: nil) }
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
    
    func shopRemoved() {
        navigationController?.popToRootViewController(animated: true)
        updateFavorites()
        getShopByIDList()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteListCell", for: indexPath) as! ImageListCell
        let shop = favorites[indexPath.row].shop
        
        // 店名の表示
        cell.shopNameInfavoriteList.text = shop?.name
        
        // 画像の表示
        if let url = URL(string: shop?.imageUrl.shopImage1 ?? "") {
            let request = imageDownloader.getImage(url: url,
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
            cell.imageViewInFavoliteList.image = nil
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let shop = favorites[indexPath.row].shop {
            showShopInfo(shop)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navigationController = viewController as? UINavigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
