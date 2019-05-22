//
//  CitySelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class CitySelectViewController: UITableViewController {
    private let apiOperater: APIType = APIOperater()
    private var city: [City] = []
    private var prefecture: Prefecture!
    
    static func instantiate(prefecture: Prefecture) -> CitySelectViewController {
        let vc = UIStoryboard(name: "CitySelect", bundle: nil).instantiateInitialViewController() as! CitySelectViewController
        vc.prefecture = prefecture
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = prefecture.prefName
        
        getCity()
    }
    
    private func getCity() {
        apiOperater.getCity(success: { [weak self] cityResponseBody in
            self?.showCity(cityResponseBody)
            }, failure: { error in
                self.showError(error)
        })
    }
    
    private func showCity(_ cityResponseBody: CityResponseBody) {
        for data in cityResponseBody.city {
            if prefecture.prefName == data.pref.prefName {
                city.append(data)
            }
        }
        self.tableView.reloadData()
    }
    
    private func showError(_ error: Error) {
        print(error) //とりあえず
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = city[indexPath.row].cityName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TownSelectViewController.instantiate(city: city[indexPath.row])
        show(vc, sender: nil)
    }
}
