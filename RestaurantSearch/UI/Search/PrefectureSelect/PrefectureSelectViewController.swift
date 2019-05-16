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
    private var prefectures: [Prefecture] = []
    var prefName: String = ""
    var areaName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = areaName
        
        apiOperater.getPrefecture(success: { [weak self] prefectureResponseBody in
            self?.showPrefecture(prefectureResponseBody)
        }, failure: { error in
            self.showError(error)
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrefectureCell", for: indexPath)
        cell.textLabel?.text = prefectures[indexPath.row].prefName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prefectures.count
    }
    
    func showPrefecture(_ prefectureResponseBody: PrefectureResponseBody) {
        self.prefectures = prefectureResponseBody.pref
        self.tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print(error) //とりあえず
    }
}
