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
    private var selectedCity: City!
    var prefecture: Prefecture!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = prefecture.prefName
        
        getCity()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = city[indexPath.row].areanameL
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = city[indexPath.row]
        performSegue(withIdentifier: "toTownSelect", sender: self)
    }
    
    func getCity() {
        apiOperater.getCity(success: { [weak self] cityResponseBody in
            self?.showCity(cityResponseBody)
            }, failure: { error in
                self.showError(error)
        })
    }
    
    func showCity(_ cityResponseBody: CityResponseBody) {
        for data in cityResponseBody.gareaLarge {
            if prefecture.prefName == data.pref.prefName {
                city.append(data)
            }
        }
        self.tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print(error) //とりあえず
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let townSelectViewController = segue.destination as? TownSelectViewController
        townSelectViewController?.city = selectedCity
    }
}
