//
//  SearchTopDetailViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/07/02.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class SearchTopDetailViewController: UITableViewController, UITextFieldDelegate, TownSelectViewControllerDelegate {
    @IBOutlet weak private var freewordTextField: UITextField!
    @IBOutlet weak private var areaSelectButton: UIButton!
    @IBOutlet weak private var searchButton: UIButton!
    private var selectedTown: Town?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.height - view.safeAreaInsets.top) / 3 // 3は使っているセルの数
    }
    
    private func layout() {
        areaSelectButton.layer.cornerRadius = 5.0
        searchButton.layer.cornerRadius = 5.0
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
    
    // MARK: - Actions
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        freewordTextField.resignFirstResponder()
    }
    
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
    
    @IBAction func myListButtonTapped(_ sender: UIButton) {
        showFavoriteList()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        freewordTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - TownSelectViewControllerDelegate
    
    func townSelected(_ town: Town) {
        navigationController?.popToRootViewController(animated: true)
        areaSelectButton.titleLabel?.text = town.townName
        selectedTown = town
    }
}
