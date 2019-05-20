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
    private var selectedPrefecture: [Prefecture] = []
    var prefName: String = ""
    var areaName: String = ""
    var areaCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = areaName
        
        getPrefecture()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrefectureCell", for: indexPath)
        cell.textLabel?.text = selectedPrefecture[indexPath.row].prefName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPrefecture.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        prefName = prefecture[indexPath.row].prefName
        performSegue(withIdentifier: "toCitySelect", sender: self)
    }
    
    func getPrefecture() {
        apiOperater.getPrefecture(success: { [weak self] prefectureResponseBody in
            self?.showPrefecture(prefectureResponseBody)
            }, failure: { error in
                self.showError(error)
        })
    }
    
    func showPrefecture(_ prefectureResponseBody: PrefectureResponseBody) {
        prefecture = prefectureResponseBody.pref
        for data in prefecture {
            if areaCode == data.areaCode {
                selectedPrefecture.append(data)
            }
        }
        self.tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print(error) //とりあえず
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let citySelectViewController = segue.destination as? CitySelectViewController
        citySelectViewController?.prefName = self.prefName
    }
}
