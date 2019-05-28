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
    @IBOutlet weak private var shopAdressLabel: UILabel!
    @IBOutlet weak private var shopMapView: MKMapView!
    private var shop: Shop!
    
    static func instantiate(shop: Shop) -> ShopMapViewController {
        let vc = UIStoryboard(name: "ShopMap", bundle: nil).instantiateInitialViewController() as! ShopMapViewController
        vc.shop = shop
        return vc
    }
}
