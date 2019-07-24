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
    @IBOutlet weak var addressLabel: UITextView!
    @IBOutlet weak private var mapView: MKMapView!
    private var shop: Shop!
    
    static func instantiate(shop: Shop) -> ShopMapViewController {
        let vc = UIStoryboard(name: "ShopMap", bundle: nil).instantiateInitialViewController() as! ShopMapViewController
        vc.shop = shop
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressLabel.text = shop.address
        showShopMap()
    }
    
    private func showShopMap() {
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
}
