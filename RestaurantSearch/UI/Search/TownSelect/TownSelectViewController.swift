//
//  TownSelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class TownSelectViewController: UITableViewController {
    private let apiOperater: APIType = APIOperater()
    private var town: [Town] = []
    private var selectedTown: Town!
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = city.areanameL
        
        getTown()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell", for: indexPath)
        cell.textLabel?.text = town[indexPath.row].areanameS
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return town.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTown = town[indexPath.row]
        performSegue(withIdentifier: "toSearchTopView", sender: self)
    }
    
    func getTown() {
        apiOperater.getTown(success: { [weak self] townResponseBody in
            self?.showTown(townResponseBody)
            }, failure: { error in
                self.showError(error)
        })
    }
    
    func showTown(_ townResponseBody: TownResponseBody) {
        for data in townResponseBody.gareaSmall {
            if city.areacodeL == data.gareaLarge.areacodeL {
                town.append(data)
            }
        }
        self.tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print(error) //とりあえず
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let searchTopViewController = segue.destination as? SearchTopTableViewController
        searchTopViewController?.areaInfo = selectedTown
    }
}
