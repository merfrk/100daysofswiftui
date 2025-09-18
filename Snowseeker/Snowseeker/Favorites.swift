//
//  Favorites.swift
//  Snowseeker
//
//  Created by Omer on 18.09.2025.
//

import SwiftUI

@Observable
class Favorites {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"
    let defaults = UserDefaults.standard

    init() {
        // load our saved data
        if let savedResorts = defaults.array(forKey: key) as? [String] {
            resorts = Set(savedResorts)
            
        }else {
            resorts = []
        }

        
        
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set and saves the change
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }

    func save() {
        defaults.set(Array(resorts), forKey: key)
    }
}
