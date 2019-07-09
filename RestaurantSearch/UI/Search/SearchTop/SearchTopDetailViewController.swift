//
//  SearchTopDetailViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/07/02.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class SearchTopDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var freewordTextField: UITextField!
    @IBOutlet weak private var areaSelectButton: UIButton!
    @IBOutlet weak private var searchButton: UIButton!
    @IBOutlet weak private var areaDeleteButton: UIButton!
    @IBOutlet weak var freewordDeleteButton: UIButton!
    private var selectedTown: Town?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        areaDeleteButton.isHidden = true
        freewordDeleteButton.isHidden = true
    }
    
    private func showAreaSelect() {
        let vc = AreaSelectViewController.instantiate()
        show(vc, sender: nil)
    }
    
    private func showShopList() {
        let vc = ShopListViewController.instantiate(townCode: selectedTown?.townCode ?? "", freeword: freewordTextField.text ?? "")
        show(vc, sender: nil)
    }
    
    private func showValidationAlert() {
        let alertController = UIAlertController(title: "Error", message: "検索条件を入力してください", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    private func validateInput() -> Bool {
        return selectedTown?.townCode == nil && freewordTextField.text == ""
    }
    
    private func showFavoriteList() {
        let vc = FavoriteListViewController.instantiate()
        show(vc, sender: nil)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.height - view.safeAreaInsets.top) / 3 // 3は使っているセルの数
    }
    
    // MARK: - Actions
    
    @IBAction func areaButtonTapped(_ sender: UIButton) {
        showAreaSelect()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        if validateInput() {
            showValidationAlert()
        } else {
            showShopList()
        }
    }
    
    @IBAction func areaDeleteButtonTapped(_ sender: UIButton) {
        if selectedTown != nil {
            selectedTown = nil
            areaSelectButton.setTitle("エリアで検索", for: .normal)
            tableView.reloadData()
        }
    }
    
    @IBAction func myListButtonTapped(_ sender: UIButton) {
        showFavoriteList()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        freewordTextField.resignFirstResponder()
        if freewordTextField.text != "" {
            freewordDeleteButton.isHidden = false
        } else {
           freewordDeleteButton.isHidden = true
        }
        return true
    }
    
    // MARK: - TownSelectViewControllerDelegate
    
    func townSelected(_ town: Town) {
        navigationController?.popToRootViewController(animated: true)
        areaSelectButton.setTitle(town.townName, for: .normal)
        selectedTown = town
        areaDeleteButton.isHidden = false
    }
}
