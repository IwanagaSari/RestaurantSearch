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
    private var selectedCity: [City] = []
    private var city: [City] = []
    var prefName: String = ""
    var areanameL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = prefName
        
        getCity()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = selectedCity[indexPath.row].areanameL
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCity.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        areanameL = city[indexPath.row].areanameL
    }
    
    func getCity() {
        apiOperater.getCity(success: { [weak self] cityResponseBody in
            self?.showCity(cityResponseBody)
            }, failure: { error in
                self.showError(error)
        })
    }
    
    func showCity(_ cityResponseBody: CityResponseBody) {
        city = cityResponseBody.gareaLarge
        for data in city {
            if prefName == data.pref.prefName {
                selectedCity.append(data)
            }
        }
        self.tableView.reloadData()
        print(selectedCity.count)
    }
    
    func showError(_ error: Error) {
        print(error) //とりあえず
    }
}
