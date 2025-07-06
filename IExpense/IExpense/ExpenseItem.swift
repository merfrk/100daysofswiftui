//
//  ExpenseItem.swift
//  IExpense
//
//  Created by Omer on 6.07.2025.
//
import Foundation
import SwiftData

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

