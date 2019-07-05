//
//  SearchTopViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/24.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class SearchTopViewController: UIViewController, TownSelectViewControllerDelegate {
    private var detailViewController: SearchTopDetailViewController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // NavigationBar 非表示
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // NavigationBar 表示
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture()
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchTopViewController.tapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        detailViewController = segue.destination as? SearchTopDetailViewController
    }
    
    func townSelected(_ town: Town) {
        navigationController?.popToRootViewController(animated: true)
        
        detailViewController?.townSelected(town)
    }
    
    // MARK: - Actions
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        detailViewController?.freewordTextField.resignFirstResponder()
    }
}
