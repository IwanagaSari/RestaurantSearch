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
    @IBOutlet weak private var addButton: UIBarButtonItem!
    @IBOutlet weak private var deleteButton: UIBarButtonItem!
    private var shop: Shop!
    private let imageDownloader = ImageDownloader.shared
    private var imageList: [String] = []
    private let defaults = UserDefaults.standard
    
    static func instantiate(shop: Shop) -> ShopInfoViewController {
        let vc = UIStoryboard(name: "ShopInfo", bundle: nil).instantiateInitialViewController() as! ShopInfoViewController
        vc.shop = shop
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTopInfo()
        showTopImage()
        updateImageList()
        showUIBarButton()
    }
    
    private func showTopInfo() {
        shopNameLabel.text = shop.name
        shopAdressLabel.text = shop.address
    }
    
    private func showTopImage() {
        let topImageURL = URL(string: shop.imageUrl.shopImage1)!
        
        imageDownloader.getImage(url: topImageURL,
                                 success: { [weak self] topImage in
                                    self?.shopTopImageView.image = topImage
                                 },
                                 failure: { [weak self] error in
                                    self?.showError(error)
                                 }
        )
    }
    
    private func showShopMap() {
        let vc = ShopMapViewController.instantiate(shop: shop)
        show(vc, sender: nil)
    }
    
    private func showError(_ error: Error) {
        print(error.localizedDescription)
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
        let setting = Setting(defaults: defaults)
        if setting.shopID.contains(shop.id) {
            // shopIDがすでに保存されていたら削除ボタンだけを表示
            addButton.isEnabled = false
            addButton.tintColor = UIColor.clear
        } else {
            // shopIDが保存されていなかった＋ボタンだけを表示
            deleteButton.isEnabled = false
            deleteButton.tintColor = UIColor.clear
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopInfoCell", for: indexPath)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        
        let imageURL = URL(string: imageList[indexPath.row])!
        
        imageDownloader.getImage(url: imageURL,
                                 success: { shopImage in
                                    imageView.image = shopImage
                                 },
                                 failure: { [weak self] error in
                                    self?.showError(error)
                                 }
        )
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
        let setting = Setting(defaults: defaults)
        setting.shopID.append(shop.id)
        showFavoriteList()
    }
    
    /// 削除ボタンをタップされた時
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        let setting = Setting(defaults: defaults)
        setting.shopID.remove(at: setting.shopID.index(of: shop.id)!)
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
        // 仮に「一蘭」というお店だとする
        var components = URLComponents(string: "https://www.google.co.jp/search")!
        components.queryItems = [URLQueryItem(name: "q", value: shop.name)]
        if let url = components.url {
            let safari = SFSafariViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
    }
}
