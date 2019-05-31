//
//  ShopMapViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class ShopMapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var shopAdressLabel: UILabel!
    @IBOutlet weak var shopMapView: MKMapView!
    
    // 現在地の位置情報の取得にはCLLocationManagerを使用
    var lm: CLLocationManager!
    // 取得した緯度を保持するインスタンス
    var latitude2: CLLocationDegrees!
    // 取得した経度を保持するインスタンス
    var longitude2: CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
        let latitude = 33.593713
        let longitude = 130.407861

        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        shopMapView.setCenter(center, animated: true)
        
        // 表示領域.
        let mySpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let myRegion = MKCoordinateRegion(center: center, span: mySpan)
        shopMapView.region = myRegion

        var myPin = MKPointAnnotation()
        myPin.coordinate = center

        myPin.title = "お店"
        myPin.subtitle = "サブタイトル"

        shopMapView.addAnnotation(myPin)
        
        // フィールドの初期化
        lm = CLLocationManager()
        longitude2 = CLLocationDegrees()
        latitude2 = CLLocationDegrees()
        
        // CLLocationManagerをDelegateに指定
        lm.delegate = self
        // 位置情報取得の許可を求めるメッセージの表示．必須．
        lm.requestAlwaysAuthorization()
    }
    
    /* 位置情報取得成功時に実行される関数 */
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
        // 取得した緯度がnewLocation.coordinate.longitudeに格納されている
        latitude2 = newLocation.coordinate.latitude
        // 取得した経度がnewLocation.coordinate.longitudeに格納されている
        longitude2 = newLocation.coordinate.longitude
        // 取得した緯度・経度をLogに表示
        NSLog("latiitude: \(latitude2) , longitude: \(longitude2)")
        
        // GPSの使用を停止する．停止しない限りGPSは実行され，指定間隔で更新され続ける．
        // lm.stopUpdatingLocation()
    }
    
    /* 位置情報取得失敗時に実行される関数 */
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        // この例ではLogにErrorと表示するだけ．
        NSLog("Error")
    }
}
