//
//  ShopInfoViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/26.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit
import SafariServices
import MapKit

final class ShopInfoViewController: UITableViewController {
    @IBOutlet weak private var category: UILabel!
    @IBOutlet weak private var nameKanaLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var prShortLabel: UILabel!
    @IBOutlet weak private var topImageView: UIImageView!
    @IBOutlet weak private var errorBackgroundView: UIView!
    @IBOutlet weak private var errorMessageLabel: UILabel!
    @IBOutlet weak private var prLongLabel: UILabel!
    @IBOutlet weak private var shopAdressLabel: UILabel!
    @IBOutlet weak private var opentimeLavel: UILabel!
    @IBOutlet weak private var holidayLabel: UILabel!
    @IBOutlet weak private var telButton: UIButton!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet private var addButton: UIBarButtonItem!
    @IBOutlet private var deleteButton: UIBarButtonItem!
    var shop: Shop!
    private let imageDownloader = ImageDownloader.shared
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
    }
    
    private func showTopInfo() {
        category.text = shop.category
        nameKanaLabel.text = shop.nameKana
        nameLabel.text = shop.name
        prShortLabel.text = shop.pr.prShort
        prLongLabel.text = shop.pr.prLong
        shopAdressLabel.text = shop.address
        opentimeLavel.text = shop.opentime
        holidayLabel.text = shop.holiday
        telButton.titleLabel?.text = shop.tel
        addressLabel.text = shop.address
    }
    
    private func getTopImage() {
        if shop.imageUrl.shopImage1.isEmpty {
            topImageView.image = UIImage(named: "error")
        } else {
            let topImageURL = URL(string: shop.imageUrl.shopImage1)!
            
            imageDownloader.getImage(url: topImageURL,
                                     success: { [weak self] topImage in
                                        self?.showImage(topImage)
                },
                                     failure: { [weak self] error in
                                        self?.showImageError(error)
            })
        }
    }
    
    private func showShopMap() {
        let vc = ShopMapViewController.instantiate(shop: shop)
        show(vc, sender: nil)
    }
    
    private func showImage(_ topImage: UIImage) {
        topImageView.image = topImage
    }
    
    private func showImageError(_ error: Error) {
        errorMessageLabel.text = error.localizedDescription
    }
    
    private func showFavoriteList() {
        let vc = FavoriteListViewController.instantiate()
        show(vc, sender: nil)
    }
    
    private func showUIBarButton() {
        let isFavorite = database.contain(shop.id)
        navigationItem.rightBarButtonItems = isFavorite ? [deleteButton] : [addButton]
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
