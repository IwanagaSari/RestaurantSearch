//
//  Setting.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/05.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import Foundation

protocol FavoriteDatabaseType {
    func add(_ shopID: String)
    func remove(_ shopID: String)
    func contain(_ shopID: String) -> Bool
    func all() -> [String]
}

final class FavoriteDatabase: FavoriteDatabaseType {
    private let defaults: UserDefaults
    static let shared = FavoriteDatabase(defaults: UserDefaults.standard)
    private static let shopIDsKey: String = "shopID"
    
    var shopIDList: [String] {
        get {
            let shopID = defaults.object(forKey: type(of: self).shopIDsKey) as? [String]
            return shopID ?? []
        }
        set {
            defaults.set(newValue, forKey: type(of: self).shopIDsKey)
            defaults.synchronize()
        }
    }
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    func add(_ shopID: String) {
        if shopIDList.contains(shopID) {
            return
        } else {
            shopIDList.append(shopID)
        }
    }
    
    func remove(_ shopID: String) {
        if shopIDList.contains(shopID) {
            shopIDList.remove(at: shopIDList.index(of: shopID)!)
        } else {
            return
        }
    }
    
    func contain(_ shopID: String) -> Bool {
        return shopIDList.contains(shopID)
    }
    
    func all() -> [String] {
        return shopIDList
    }
}
