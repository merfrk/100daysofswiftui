//
//  IExpenseApp.swift
//  IExpense
//
//  Created by Omer on 22.06.2025.
//
import SwiftData
import SwiftUI

@main
struct IExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ExpenseItem.self)
        }
    }
}
