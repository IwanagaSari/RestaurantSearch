//
//  TownSelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class TownSelectViewController: UITableViewController {
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorTextView: UITextView!
    private let apiOperater: APIType = APIOperater()
    private var town: [Town] = []
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
        self.tableView.backgroundView = errorView
    }
    
    private func getTown() {
        apiOperater.getTown(
            success: { [weak self] townResponseBody in
                self?.showTown(townResponseBody)
            },
            failure: { error in
                self.showError(error)
            }
        )
    }
    
    private func showTown(_ townResponseBody: TownResponseBody) {
        for data in townResponseBody.town {
            if city.cityCode == data.city.cityCode {
                town.append(data)
            }
        }
        self.tableView.reloadData()
    }
    
    private func showError(_ error: Error) {
       self.errorTextView.text = error.localizedDescription
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell", for: indexPath)
        cell.textLabel?.text = town[indexPath.row].townName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return town.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SearchTopTableViewController()
        show(vc, sender: nil)
    }
}
