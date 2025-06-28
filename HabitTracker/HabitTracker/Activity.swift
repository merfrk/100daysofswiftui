//
//  Activity.swift
//  HabitTracker
//
//  Created by Omer on 28.06.2025.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var completionCount: Int

    init(id: UUID = UUID(), title: String, description: String, completionCount: Int = 0) {
        self.id = id
        self.title = title
        self.description = description
        self.completionCount = completionCount
    }
}
