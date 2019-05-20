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
    private var area: [Area] = []
    private var selectedArea: Area!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArea()
        
        self.tableView.backgroundView = errorView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath)
        cell.textLabel?.text = area[indexPath.row].areaName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return area.count
    }
    
    //セル選択時にエリア名をareaNameに代入
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArea = area[indexPath.row]
        performSegue(withIdentifier: "toPrefectureSelect", sender: self)
    }
    
    func getArea() {
        apiOperater.getArea(success: { [weak self] areaResponseBody in
            self?.showArea(areaResponseBody)
            }, failure: { [weak self] error in
                self?.showError(error)
        })
    }
    
    func showArea(_ areaResponseBody: AreaResponseBody) {
        self.area = areaResponseBody.area
        self.tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        self.errorTextView.text = error.localizedDescription
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let prefectureSelectViewController = segue.destination as? PrefectureSelectViewController
        prefectureSelectViewController?.area = selectedArea
    }
}
