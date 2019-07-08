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

protocol ShopInfoViewControllerDelegate: AnyObject {
    func shopRemoved()
}

final class ShopInfoViewController: UITableViewController, UITabBarControllerDelegate {
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
        
        tabBarController?.delegate = self
        showTopInfo()
        showMapView()
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
        let vc = navigationController?.viewControllers.first as? ShopInfoViewControllerDelegate
        vc?.shopRemoved()
    }
    
    private func showUIBarButton() {
        let isFavorite = database.contain(shop.id)
        navigationItem.rightBarButtonItems = isFavorite ? [deleteButton] : [addButton]
    }
    
    private func showMapView() {
        let latitude = Double(shop.latitude)!
        let longitude = Double(shop.longitude)!
        let center = CLLocationCoordinate2DMake(latitude, longitude)
        mapView.setCenter(center, animated: true)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
        
        let pin = MKPointAnnotation()
        pin.coordinate = center
        
        pin.title = shop.name
        pin.subtitle = shop.category
        
        mapView.addAnnotation(pin)
    }
    
    private func showValidationAlert() {
        let alertController = UIAlertController(title: "追加完了！", message: "お気に入りに追加しました", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    /// 追加するボタンをタップされた時
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        database.add(shop.id)
        showValidationAlert()
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
    
    // storyboad上でCellのデザインを見やすくするため、あえてコード上で設定
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let vc = FavoriteListViewController.instantiate()
        show(vc, sender: nil)
    }
}
