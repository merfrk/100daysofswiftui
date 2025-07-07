//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Omer on 7.07.2025.
//
import SwiftData
import SwiftUI

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ExpenseItem.self)
        }
    }
}
