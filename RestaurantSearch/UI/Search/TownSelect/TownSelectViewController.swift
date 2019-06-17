//
//  TownSelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class TownSelectViewController: UITableViewController {
    @IBOutlet private var errorView: UIView!
    @IBOutlet weak private var errorMessageLabel: UILabel!
    var apiOperater: APIType = APIOperater()
    private var townList: [Town] = []
    private var city: City!
    
    static func instantiate(city: City) -> TownSelectViewController {
        let vc = UIStoryboard(name: "TownSelect", bundle: nil).instantiateInitialViewController() as! TownSelectViewController
        vc.city = city
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = city.cityName
        
        getTown()
    }
    
    private func getTown() {
        apiOperater.getTown(
            success: { [weak self] townResponseBody in
                self?.showTown(townResponseBody)
            },
            failure: { [weak self] error in
                self?.showError(error)
            }
        )
    }
    
    private func showTown(_ townResponseBody: TownResponseBody) {
        townList = townResponseBody.townList.filter { $0.city.cityCode == city.cityCode }
        tableView.backgroundView = nil
        tableView.reloadData()
    }
    
    private func showError(_ error: Error) {
        errorMessageLabel.text = error.localizedDescription
        tableView.backgroundView = errorView
    }
    
    private func showSearchTop(_ town: Town) {
        let vc = SearchTopTableViewController.instantiate(town: town)
        show(vc, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell", for: indexPath)
        cell.textLabel?.text = townList[indexPath.row].townName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return townList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let town = townList[indexPath.row]
        showSearchTop(town)
    }
}
