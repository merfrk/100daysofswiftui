//
//  iExpenseWithSwiftDataApp.swift
//  iExpenseWithSwiftData
//
//  Created by Omer on 24.08.2025.
//
import SwiftData
import SwiftUI

@main
struct iExpenseWithSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
