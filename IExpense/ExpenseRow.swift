//
//  ExpenseRow.swift
//  IExpense
//
//  Created by Omer on 6.07.2025.
//

import Foundation
import SwiftUI

struct ExpenseRow: View {
    let item: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
                Text(item.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundColor(item.amountColor)
                .font(item.amountFont)
        }
    }
}

extension ExpenseItem {
    var amountColor: Color {
        switch amount {
        case ..<10: return .green
        case ..<100: return .orange
        default: return .red
        }
    }

    var amountFont: Font {
        switch amount {
        case ..<10: return .body
        case ..<100: return .headline
        default: return .title3.weight(.bold)
        }
    }
}
