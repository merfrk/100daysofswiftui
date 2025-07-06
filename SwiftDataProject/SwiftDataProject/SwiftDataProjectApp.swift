//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Omer on 6.07.2025.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
