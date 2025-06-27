//
//  ContentView.swift
//  IExpense
//
//  Created by Omer on 22.06.2025.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

struct ExpenseRow: View {
    let item: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }

            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundColor(amountColor(for: item.amount))
                .font(amountFont(for: item.amount))
        }
    }

    func amountColor(for amount: Double) -> Color {
        switch amount {
        case ..<10: return .green
        case ..<100: return .orange
        default: return .red
        }
    }

    func amountFont(for amount: Double) -> Font {
        switch amount {
        case ..<10: return .body
        case ..<100: return .headline
        default: return .title3.weight(.bold)
        }
    }
}


@Observable
class Expenses{
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    
    
    var body: some View {
        NavigationStack {
                List {
                    Section("Business") {
                        ForEach(businessItems) { item in
                            ExpenseRow(item: item)
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, in: businessItems)
                        }
                    }

                    Section("Personal") {
                        ForEach(personalItems) { item in
                            ExpenseRow(item: item)
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, in: personalItems)
                        }
                    }
                }
                .navigationTitle("iExpense")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink{
                            AddView(expenses: expenses)
                        }
                        label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            
            
            }
    }
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    func amountColor(for amount: Double) -> Color {
        switch amount {
        case ..<10:
            return .green
        case ..<100:
            return .orange
        default:
            return .red
        }
    }

    func amountFont(for amount: Double) -> Font {
        switch amount {
        case ..<10:
            return .body
        case ..<100:
            return .headline
        default:
            return .title3.weight(.bold)
        }
    }
    var businessItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }

    var personalItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }

    func removeItems(at offsets: IndexSet, in items: [ExpenseItem]) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: { $0.id == items[offset].id }) {
                expenses.items.remove(at: index)
            }
        }
    }


}


#Preview {
    ContentView()
}
