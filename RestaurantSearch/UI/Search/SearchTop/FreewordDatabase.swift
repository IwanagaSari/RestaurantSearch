//
//  FreewordDatabase.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/19.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import Foundation
protocol FreewordDatabaseType {
    func get() -> String
    func set(_ inputFreeword: String?)
    func remove()
}

final class FreewordDatabase: FreewordDatabaseType {
    private let defaults: UserDefaults
    static let shared = FreewordDatabase(defaults: UserDefaults.standard)
    private static let freewordKey = "freeword"
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    private var freeword: String {
        get {
            let freeword = defaults.object(forKey: type(of: self).freewordKey) as? String
            return freeword ?? ""
        }
        set {
            defaults.set(newValue, forKey: type(of: self).freewordKey)
            defaults.synchronize()
        }
    }
    
    func get() -> String {
        return freeword
    }
    
    func set(_ inputFreeword: String?) {
        if let inputFreeword = inputFreeword {
            freeword = inputFreeword
        }
    }
    
    func remove() {
        freeword.removeAll()
    }
}
