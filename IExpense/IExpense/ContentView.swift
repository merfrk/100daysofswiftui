//
//  ContentView.swift
//  IExpense
//
//  Created by Omer on 22.06.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \ExpenseItem.date, order: .reverse) var items: [ExpenseItem]
    
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                Section("Business") {
                    ForEach(businessItems) { item in
                        ExpenseRow(item: item)
                    }
                    .onDelete { indexSet in
                        deleteItems(indexSet, from: businessItems)
                    }
                }

                Section("Personal") {
                    ForEach(personalItems) { item in
                        ExpenseRow(item: item)
                    }
                    .onDelete { indexSet in
                        deleteItems(indexSet, from: personalItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }

    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business" }
    }

    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }

    func deleteItems(_ offsets: IndexSet, from list: [ExpenseItem]) {
        for offset in offsets {
            let item = list[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ContentView()
}
