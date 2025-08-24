//
//  ExpenseItem.swift
//  iExpenseWithSwiftData
//
//  Created by Omer on 24.08.2025.
//
import SwiftData
import Foundation

@Model
class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    var date: Date
    
    init(name: String, type: String, amount: Double, date: Date = .now) {
        self.name = name
        self.type = type
        self.amount = amount
        self.date = date
    }
}
