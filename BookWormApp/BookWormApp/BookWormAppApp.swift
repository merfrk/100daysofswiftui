//
//  BookWormAppApp.swift
//  BookWormApp
//
//  Created by Omer on 2.07.2025.
//

import SwiftUI
import SwiftData

@main
struct BookWormAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
