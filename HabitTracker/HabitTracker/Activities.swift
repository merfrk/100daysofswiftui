//
//  Activities.swift
//  HabitTracker
//
//  Created by Omer on 28.06.2025.
//

import Foundation
import SwiftUI

class Activities: ObservableObject {
    @Published var items: [Activity] = [] {
        didSet {
            save()
        }
    }

    private let saveKey = "SavedActivities"

    init() {
        load()
    }

    func add(_ activity: Activity) {
        items.append(activity)
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Activity].self, from: data) {
            items = decoded
        }
    }
}
