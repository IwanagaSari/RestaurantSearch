//
//  AreaSelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/04/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit

final class AreaSelectViewController: UITableViewController {
    @IBOutlet private var errorView: UIView!
    @IBOutlet weak private var errorMessageLabel: UILabel!
    var apiOperater: APIType = APIOperater()
    private var areaList: [Area] = []
    
    static func instantiate() -> AreaSelectViewController {
        let vc = UIStoryboard(name: "AreaSelect", bundle: nil).instantiateInitialViewController() as! AreaSelectViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArea()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AreaCell")
    }
    
    private func getArea() {
        apiOperater.getArea(
            success: { [weak self] areaResponseBody in
                self?.showArea(areaResponseBody)
            },
            failure: { [weak self] error in
                self?.showError(error)
            }
        )
    }
    
    private func showArea(_ areaResponseBody: AreaResponseBody) {
        areaList = areaResponseBody.areaList
        tableView.backgroundView = nil
        tableView.reloadData()
    }
    
    private func showError(_ error: Error) {
        errorMessageLabel.text = error.localizedDescription
        tableView.backgroundView = errorView
    }
    
    private func showPrefectureSelect(_ area: Area) {
        let vc = PrefectureSelectViewController.instantiate(area: area)
        show(vc, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath)
        let area = areaList[indexPath.row]
        cell.textLabel?.text = area.areaName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let area = areaList[indexPath.row]
        showPrefectureSelect(area)
    }
}
