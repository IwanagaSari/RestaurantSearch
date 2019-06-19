//
//  SearchTopTableViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/04/22.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit

final class SearchTopTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak private var freewordSearchBar: UITextField!
    @IBOutlet weak private var areaLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var sceneLabel: UILabel!
    private var inputTown: Town?
    let freewordDatabase = FreewordDatabase.shared
    
    static func instantiate(town: Town) -> SearchTopTableViewController {
        let vc = UIStoryboard(name: "SearchTop", bundle: nil).instantiateInitialViewController() as! SearchTopTableViewController
        vc.inputTown = town
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateArea()
        updateFreeword()
    }
    
    private func updateArea() {
        if let town = inputTown {
            areaLabel.text = town.townName
        }
    }
    
    private func updateFreeword() {
        freewordSearchBar.text = freewordDatabase.get()
    }
    
    private func showAreaSelect() {
        let vc = AreaSelectViewController.instantiate()
        show(vc, sender: nil)
    }
    
    private func showShopList() {
        let vc = ShopListViewController.instantiate(townCode: inputTown?.townCode ?? "", freeword: freewordSearchBar.text ?? "")
        show(vc, sender: nil)
    }
    
    private func showValidationAlert() {
        let alertController = UIAlertController(title: "Error", message: "検索条件を入力してください", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    private func validateInput() -> Bool {
        return inputTown?.townCode == nil && freewordSearchBar.text == ""
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            showAreaSelect()
            freewordDatabase.set(freewordSearchBar.text)
        case 4:
            if validateInput() {
                showValidationAlert()
            } else {
                showShopList()
            }
        default:
            return
        }
    }
    
    // MARK: - Actions

    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        freewordSearchBar.resignFirstResponder()
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        freewordSearchBar.resignFirstResponder()
        return true
    }
}
