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
    private var shopList: [Shop] = []
    private let imageDownloader = ImageDownloader.shared
    private var townCode: String = "AREAS5504" // とりあえず
    private var freeword: String = "焼肉"
    @IBOutlet private var errorView: UIView!
    @IBOutlet weak private var errorTextView: UITextView!
    
    static func instantiate(townCode: String, freeword: String) -> ShopListViewController {
        let vc = UIStoryboard(name: "ShopList", bundle: nil).instantiateInitialViewController() as! ShopListViewController
        vc.townCode = townCode
        vc.freeword = freeword
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShop()
        collectionView.backgroundView = errorView
    }
    
    private func getShop() {
        apiOperater.getShop(townCode: townCode,
                            freeword: freeword,
                            success: { [weak self] shopResponseBody in
                                self?.showShopList(shopResponseBody)
                            },
                            failure: { [weak self] error in
                                self?.showError(error)
                            })
    }
    
    private func showShopList(_ shopResponseBody: ShopResponseBody) {
        shopList = shopResponseBody.shop
        collectionView.reloadData()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopListCell", for: indexPath) as! ImageListCell
        let imageURL = URL(string: shopList[indexPath.row].imageUrl.shopImage1)!
        
        let request = imageDownloader.getImage(url: imageURL,
                                               success: { shopImage in
                                                   cell.imageViewInShopList.image = shopImage
                                               },
                                               failure: { [weak self] error in
                                                   self?.showError(error)
                                               })
        cell.onReuse = {
            request?.cancel()
        }
    
        cell.shopNameInShopList.text = shopList[indexPath.row].name
        
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
