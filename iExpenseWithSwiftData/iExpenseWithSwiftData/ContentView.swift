//
//  ContentView.swift
//  iExpenseWithSwiftData
//
//  Created by Omer on 24.08.2025.
//





//
//  ContentView.swift
//  iExpenseWithSwiftData
//
//  Created by Omer on 24.08.2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenseItems: [ExpenseItem]
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    @State private var selectedFilter: ExpenseFilter = .all
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Filter picker
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(ExpenseFilter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    ForEach(filteredExpenses) { item in
                        ExpenseRow(item: item)
                    }
                    .onDelete(perform: deleteExpenses)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        }
                    }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView()
            }
        }
    }
    
    var filteredExpenses: [ExpenseItem] {
        let filtered: [ExpenseItem]
        
        switch selectedFilter {
        case .all:
            filtered = expenseItems
        case .personal:
            filtered = expenseItems.filter { $0.type == "Personal" }
        case .business:
            filtered = expenseItems.filter { $0.type == "Business" }
        }
        
        // Apply sorting
        return filtered.sorted(using: sortOrder)
    }
    
    func deleteExpenses(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(filteredExpenses[index])
            }
        }
    }
    
    init() {
        // Initialize with all expenses, filtering will be handled by computed property
        _expenseItems = Query(sort: [
            SortDescriptor(\ExpenseItem.name),
            SortDescriptor(\ExpenseItem.amount)
        ])
    }
}

enum ExpenseFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case personal = "Personal"
    case business = "Business"

    var id: String { self.rawValue }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self, inMemory: true)
}







/*
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenseItems: [ExpenseItem]
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    @State private var showNameOnly = true
    @State private var selectedFilter: ExpenseFilter = .all
    
    
    
    var body: some View {
        NavigationStack{
            VStack{
                List(expenseItems) { item in
                    ExpenseRow(item: item)
                }
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add Expense", systemImage: "plus"){
                    AddView()
                }
                
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(ExpenseFilter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder){
                        Text("Sort by Name")
                            .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.amount),
                                SortDescriptor(\ExpenseItem.name)
                            ])
                    }
                }
            }
        }
    }
    init(type: String, sortOrder: [SortDescriptor<ExpenseItem>]){
        _expenseItems = Query(filter: #Predicate<ExpenseItem>{ item in
            item.type == selectedFilter.rawValue
        }, sort: sortOrder)
    }
    
    enum ExpenseFilter: String, CaseIterable, Identifiable {
        case all = "All"
        case personal = "Personal"
        case business = "Business"

        var id: String { self.rawValue }
    }
}

#Preview {
    ContentView(type: "Personal", sortOrder: [SortDescriptor(\ExpenseItem.name)])
}
*/
