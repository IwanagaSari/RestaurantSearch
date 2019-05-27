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
    @IBOutlet weak private var errorTextView: UITextView!
    private let apiOperater: APIType = APIOperater()
    private var areaList: [Area] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArea()
        self.tableView.backgroundView = errorView
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
        self.areaList = areaResponseBody.area
        self.tableView.reloadData()
    }
    
    private func showError(_ error: Error) {
        self.errorTextView.text = error.localizedDescription
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
        let vc = PrefectureSelectViewController.instantiate(area: areaList[indexPath.row])
        show(vc, sender: nil)
    }
}
