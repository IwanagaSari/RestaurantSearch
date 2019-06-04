//
//  PrefectureSelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class PrefectureSelectViewController: UITableViewController {
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorTextView: UITextView!
    var apiOperater: APIType = APIOperater()
    private var prefectureList: [Prefecture] = []
    private var area: Area!
    
    static func instantiate(area: Area) -> PrefectureSelectViewController {
        let vc = UIStoryboard(name: "PrefectureSelect", bundle: nil).instantiateInitialViewController() as! PrefectureSelectViewController
        vc.area = area
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = area.areaName
        
        getPrefecture()
        self.tableView.backgroundView = errorView
    }
    
    private func getPrefecture() {
        apiOperater.getPrefecture(
            success: { [weak self] prefectureResponseBody in
                self?.showPrefecture(prefectureResponseBody)
            },
            failure: { [weak self] error in
                self?.showError(error)
            }
        )
    }
    
    private func showPrefecture(_ prefectureResponseBody: PrefectureResponseBody) {
        prefectureList = prefectureResponseBody.prefectureList.filter { $0.areaCode == area.areaCode }
        self.tableView.reloadData()
    }
    
    private func showError(_ error: Error) {
        self.errorTextView.text = error.localizedDescription
    }
    
    private func showCitySelect(_ prefecture: Prefecture) {
        let vc = CitySelectViewController.instantiate(prefecture: prefecture)
        show(vc, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrefectureCell", for: indexPath)
        cell.textLabel?.text = prefectureList[indexPath.row].prefName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prefectureList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prefecture = prefectureList[indexPath.row]
        showCitySelect(prefecture)
    }
}
