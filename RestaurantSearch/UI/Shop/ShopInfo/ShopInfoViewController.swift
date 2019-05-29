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
    private var shop: Shop!
    private let imageDownloader = ImageDownloader()
    var imageList: [String] = []
    
    static func instantiate(shop: Shop) -> ShopInfoViewController {
        let vc = UIStoryboard(name: "ShopInfo", bundle: nil).instantiateInitialViewController() as! ShopInfoViewController
        vc.shop = shop
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTopInfo()
        showTopImage()
        getImageList()
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
    
    private func getImageList() {
        let allImage = [shop.imageUrl.shopImage1, shop.imageUrl.shopImage2, shop.imageUrl.qrcode]
        imageList = allImage.filter { $0 != "" }
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
        //お気に入りに入っていないお店であれば、追加ボタンを表示する
    }
    
    /// 削除ボタンをタップされた時
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        //お気に入りにすでに入っているお店なら、削除ボタンを表示する
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
        components.queryItems = [URLQueryItem(name: "q", value: "\(shop.name)")]
        if let url = components.url {
            let safari = SFSafariViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
    }
}
