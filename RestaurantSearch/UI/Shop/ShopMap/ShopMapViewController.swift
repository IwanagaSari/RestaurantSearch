//
//  ShopMapViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit
import MapKit

final class ShopMapViewController: UIViewController {
    @IBOutlet weak private var shopAddressLabel: UITextView!
    @IBOutlet weak private var shopMapView: MKMapView!
    private var shop: Shop!
    
    static func instantiate(shop: Shop) -> ShopMapViewController {
        let vc = UIStoryboard(name: "ShopMap", bundle: nil).instantiateInitialViewController() as! ShopMapViewController
        vc.shop = shop
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopAddressLabel.text = shop.address
        showShopMap()
    }
    
    func showShopMap() {
        let latitude = Double(shop.latitude)!
        let longitude = Double(shop.longitude)!
        let center = CLLocationCoordinate2DMake(latitude, longitude)
        shopMapView.setCenter(center, animated: true)
        
        let mySpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let myRegion = MKCoordinateRegion(center: center, span: mySpan)
        shopMapView.region = myRegion
        
        let myPin = MKPointAnnotation()
        myPin.coordinate = center
        
        myPin.title = shop.name
        myPin.subtitle = shop.category
        
        shopMapView.addAnnotation(myPin)
    }
}
