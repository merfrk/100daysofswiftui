//
//  BookwormmApp.swift
//  Bookwormm
//
//  Created by Omer on 22.08.2025.
//
import SwiftData
import SwiftUI

@main
struct BookwormmApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
