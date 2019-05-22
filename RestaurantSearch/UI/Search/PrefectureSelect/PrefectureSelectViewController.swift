//
//  PrefectureSelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class PrefectureSelectViewController: UITableViewController {
    private let apiOperater: APIType = APIOperater()
    private var prefecture: [Prefecture] = []
    private var selectedPrefecture: Prefecture!
    var area: Area!
    
    static func instantiate(area: Area) -> PrefectureSelectViewController {
        let vc = UIStoryboard(name: "PrefectureSelect", bundle: nil).instantiateInitialViewController() as! PrefectureSelectViewController
        vc.area = area
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = area.areaName
        
        getPrefecture()
    }
    
    func getPrefecture() {
        apiOperater.getPrefecture(success: { [weak self] prefectureResponseBody in
            self?.showPrefecture(prefectureResponseBody)
            }, failure: { error in
                self.showError(error)
        })
    }
    
    func showPrefecture(_ prefectureResponseBody: PrefectureResponseBody) {
        for data in prefectureResponseBody.pref {
            if area.areaCode == data.areaCode {
                prefecture.append(data)
            }
        }
        self.tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print(error) //とりあえず
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrefectureCell", for: indexPath)
        cell.textLabel?.text = prefecture[indexPath.row].prefName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prefecture.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPrefecture = prefecture[indexPath.row]
        performSegue(withIdentifier: "toCitySelect", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let citySelectViewController = segue.destination as? CitySelectViewController
//        citySelectViewController?.prefecture = selectedPrefecture
//    }
}
