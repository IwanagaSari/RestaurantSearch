//
//  AreaSelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/04/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit

protocol APIType {
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void)
}

class DummyAPI: APIType {
    var area: AreaResponseBody?
    var prefecture: PrefectureResponseBody?
    var city: CityResponseBody?
    var town: TownResponseBody?
    var error: Error?
    
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(area!); failure(error!)
    }
    
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(prefecture!); failure(error!)
    }
    
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(city!); failure(error!)
    }
    
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(town!); failure(error!)
    }
}

final class AreaSelectViewController: UITableViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var errorTextView: UITextView!
    let apiOperater = APIOperater()
    var areas: [Area] = []
    var areaName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiOperater.getArea(success: { areaResponseBody in
            self.areas = areaResponseBody.area
            self.tableView.reloadData()
        }, failure: { error in
            self.errorTextView.text = error.localizedDescription
        })
        self.tableView.backgroundView = backgroundView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath)
        let area = areas[indexPath.row]
        cell.textLabel?.text = area.areaName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    //セル選択時にエリア名をareaNameに代入
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.areaName = areas[indexPath.row].areaName
        performSegue(withIdentifier: "toPrefectureSelect", sender: IndexPath.self)
    }
}
