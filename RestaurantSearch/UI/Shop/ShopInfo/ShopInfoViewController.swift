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
    @IBOutlet weak private var shopNameLabel: UILabel!
    @IBOutlet weak private var shopAdressLabel: UILabel!
    @IBOutlet weak private var shopTopImageView: UIImageView!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet private var addButton: UIBarButtonItem!
    @IBOutlet private var deleteButton: UIBarButtonItem!
    @IBOutlet weak private var topErrorMessageLabel: UILabel!
    private var shop: Shop!
    private let imageDownloader = ImageDownloader.shared
    private var imageList: [String] = []
    private let database: FavoriteDatabaseType = FavoriteDatabase.shared
    
    static func instantiate(shop: Shop) -> ShopInfoViewController {
        let vc = UIStoryboard(name: "ShopInfo", bundle: nil).instantiateInitialViewController() as! ShopInfoViewController
        vc.shop = shop
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showUIBarButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTopInfo()
        getTopImage()
        updateImageList()
    }
    
    private func showTopInfo() {
        shopNameLabel.text = shop.name
        shopAdressLabel.text = shop.address
    }
    
    private func getTopImage() {
        if shop.imageUrl.shopImage1.isEmpty {
            shopTopImageView.image = UIImage(named: "error")
        } else {
            let topImageURL = URL(string: shop.imageUrl.shopImage1)!
            
            imageDownloader.getImage(url: topImageURL,
                                     success: { [weak self] topImage in
                                          self?.showTopImage(topImage)
                                     },
                                     failure: { [weak self] error in
                                          self?.showTopImageError(error)
                                     })
        }
    }
    
    private func showShopMap() {
        let vc = ShopMapViewController.instantiate(shop: shop)
        show(vc, sender: nil)
    }
    
    private func showTopImage(_ topImage: UIImage) {
        topErrorMessageLabel.text = ""
        shopTopImageView.image = topImage
    }
    
    private func showTopImageError(_ error: Error) {
        topErrorMessageLabel.text = error.localizedDescription
    }
    
    private func showFavoriteList() {
        let vc = FavoriteListViewController.instantiate()
        show(vc, sender: nil)
    }
    
    private func updateImageList() {
        let allImage = [shop.imageUrl.shopImage1, shop.imageUrl.shopImage2, shop.imageUrl.qrcode]
        imageList = allImage.filter { !$0.isEmpty }
    }
    
    private func showUIBarButton() {
        let isFavorite = database.contain(shop.id)
        navigationItem.rightBarButtonItems = isFavorite ? [deleteButton] : [addButton]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopInfoCell", for: indexPath) as! ImageListCell
        
        let imageURL = URL(string: imageList[indexPath.row])!
        
        let request = imageDownloader.getImage(url: imageURL,
                                               success: { shopImage in
                                                    cell.imageViewInShopInfo.image = shopImage
                                               },
                                               failure: { [weak self] error in
                                                    self?.showError(error)
                                               })
        cell.onReuse = {
            request?.cancel()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        
        return CGSize(width: width, height: width)
    }
    
    // MARK: - Actions
    
    /// 追加するボタンをタップされた時
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        database.add(shop.id)
        showFavoriteList()
    }
    
    /// 削除ボタンをタップされた時
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        database.remove(shop.id)
        showFavoriteList()
    }
    
    /// 地図ボタンをタップされた時
    @IBAction func mapButtonTapped(_ sender: UIButton) {
        showShopMap()
    }
    
    /// 電話をかけるボタンをタップされた時
    @IBAction func telephoneButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "telprompt://\(shop.tel)")!, completionHandler: nil)
    }
    
    /// さらに詳しくボタンをタップされた時
    @IBAction func detailButtonTapped(_ sender: UIButton) {
        var components = URLComponents(string: "https://www.google.co.jp/search")!
        components.queryItems = [URLQueryItem(name: "q", value: shop.name)]
        if let url = components.url {
            let safari = SFSafariViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
    }
}
